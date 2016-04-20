'use strict'

class XAxis
  svg = null
  width = 0
  height = 0
  x0 = 0

  constructor: (anSvg, aWidth, aHeight, ix0) ->
    svg = anSvg
    width = aWidth
    height = aHeight
    x0 = ix0

  xScale: d3.time.scale().range([0, width - 50])

  axis: d3.svg.axis()
            .scale(@xScale)
            .tickSize(1.5)
            .tickPadding(15)
            .orient('bottom')
