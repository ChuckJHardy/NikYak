class @Tree
  constructor: (@data) ->
    @margin = {top: 40, right: 120, bottom: 20, left: 120}
    @width = 960 - @margin.right - @margin.left
    @height = 500 - @margin.top - @margin.bottom

    @i = 0

    @tree = d3.layout.tree()
      .separation( (a, b) -> 2 )
      .size([@height, @width])

    @diagonal = d3.svg.diagonal()
      .projection( (d) -> [d.x, d.y])

    @svg = d3.select("body").append("svg")
      .attr("width", @width + @margin.right + @margin.left)
      .attr("height", @height + @margin.top + @margin.bottom)
      .append("g")
      .attr("transform", "translate(" + @margin.left + "," + @margin.top + ")")

    @root = @data[0]

    @update(@root)

  update: (source) =>
    nodes = @tree.nodes(@root).reverse()
    links = @tree.links(nodes)

    nodes.forEach((d) -> d.y = d.depth * 100 )

    node = @svg.selectAll("g.node")
      .data(nodes, (d) => d.id || (d.id = ++@i) )

    nodeEnter = node.enter().append("g")
      .attr("class", "node")
      .attr("transform", (d) ->
        "translate(" + d.x + "," + d.y + ")"
      )
      .on("click", (d) -> window.location = d.url )

    nodeEnter.append("circle")
      .attr("r", 10)
      .attr("class", (d) -> if d.is_current then "current" else "")

    nodeEnter.append("text")
      .attr("y", (d) -> if (d.children || d._children) then -18 else 18)
      .attr("dy", ".35em")
      .attr("text-anchor", "middle")
      .text((d) -> d.title)
      .style("fill-opacity", 1)

    link = @svg.selectAll("path.link")
      .data(links, (d) -> d.target.id)

    link.enter().insert("path", "g")
      .attr("class", "link")
      .attr("d", @diagonal)



