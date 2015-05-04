children = (d) ->
  trans = [[-1, -1], [1, -1], [1, 1], [-1, 1]]
  ({'x': d.x + d.r/2*t[0], 'y': d.y + d.r/2*t[1], 'r': d.r/2} for t in trans)


remove = (el, data) ->
  data.splice(data.indexOf(el), 1)


update = (data) ->
  # Data join
  circle = svg.selectAll("circle").data(data)

  # Enter
  circle.enter().append("circle")

  # Enter and update
  circle.attr("cx", (d) -> d.x)
    .attr("cy", (d) -> d.y)
    .attr("r", (d) -> d.r*0.95)
    .on('mouseover', (d) ->
      if d.r > 2
        data = data.concat(children(d))
        remove(d, data)
        update(data)
      )

  # Exit
  circle.exit().remove()


width = 500
height = 500

svg = d3.select("body").append("svg")
  .attr("width", width)
  .attr("height", height)

init = [{'r': width/2, 'x': width/2, 'y': height/2}]

update(init)
