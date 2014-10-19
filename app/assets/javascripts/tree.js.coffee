class @Tree
  margin:
    top: 40,
    bottom: 20

  height: 500

  treeSvgId: "tree-svg"
  treeSvgContainerId: "tree-svg-container"

  constructor: (@data, @parentContainer = "body") ->
    @tree_height = @height - @margin.top - @margin.bottom

    @i = 0

    @tree = d3.layout.tree()
      .separation( (a, b) -> 2 )
      .size([@tree_height, @width()])

    @diagonal = d3.svg.diagonal()
      .projection( (d) =>
        if @root.branches > 1
          [ d.x, d.y ]
        else
          [ 0, d.y ]
      )

    @svg = d3.select(@parentContainer).append("svg")
      .attr("id", @treeSvgId)
      .attr("width", @width())
      .attr("height", @height)
      .append("g")
      .attr("id", @treeSvgContainerId)

    @root = @data[0]

    @update(@root)

    @svg.attr("transform", "translate(" + @marginLeft() + "," + @margin.top + ")")

  update: (source) =>
    nodes = @tree.nodes(@root).reverse()
    links = @tree.links(nodes)

    nodes.forEach((d) -> d.y = d.depth * 100 )

    node = @svg.selectAll("g.node")
      .data(nodes, (d) => d.id || (d.id = ++@i) )

    nodeEnter = node.enter().append("g")
      .attr("class", "node")
      .attr("transform", (d) =>
        if @root.branches > 1
          "translate(" + d.x + "," + d.y + ")"
        else
          "translate(" + 0 + "," + d.y + ")"
      )
      .on("click", (d) -> window.location = d.url )

    nodeEnter.append("circle")
      .attr("r", 10)
      .attr("class", (d) -> if d.is_current then "current" else "")

    link = @svg.selectAll("path.link")
      .data(links, (d) -> d.target.id)


    link.enter().insert("path", "g")
      .attr("class", "link")
      .attr("d", @diagonal)

  marginLeft: =>
    @width() / 2 - ( @treeWidth() / 2 ) + 30 # this drives me insane, and all mathematicians are crying reding this

  marginRight: =>
    120

  treeWidth: =>
    document.getElementById(@treeSvgContainerId).getBBox().width

  width: =>
    $(@parentContainer).width()




