'use strict'

class Year

  utils = new Utils
  height = utils.timelineHeight - 22
  width = utils.width - 60

  xHeight = 50
  x0 = 20

  xScale = d3.time.scale().range([0, width - 50])

  parseDate = d3.time.format('%Y-%m-%d').parse

  xAxis = d3.svg.axis()
            .scale(xScale)
            .ticks(d3.time.months)
            .tickSize(1.5)
            .tickPadding(15)
            .orient('bottom')

  svg = d3.select('body .dates-container .year-container')
    .attr('style', utils.sizeStyles(width, 'auto'))
    .append('svg')
    .attr('class', 'timeline')
    .attr('width', width)
    .attr('height', height)
    .append('g')

  drawXAxis = ->
    svg.append('g')
       .attr('class', 'x axis')
       .attr('transform', 'translate(' +
                              x0 + ',' +
                              (height - xHeight) + ')')
       .call(xAxis)

  drawDotFor = (data, dotType, radius, cyK) ->
    svg.selectAll('dot')
       .data(data)
       .enter()
       .append('circle')
       .attr('class', (d) ->
                        'dot ' + dotType +
                        ' time-' + d.year.getFullYear())
       .attr('r', (d) ->
                      d[dotType]/radius)
       .attr('cx', (d) ->
                      xScale(d.year))
       .attr('cy', (height / 2) +
                   (xHeight * cyK) + 40)
       .attr('transform', 'translate(' + x0 + ')')

  getDataAndRender = ->
    d3.json 'data_sample-month.json', (error, data) ->
      return console.error(error) if error

      data.forEach( (d) ->
        d.year = parseDate(d.year + '-01-01')
      )

      xScale.domain(d3.extent(data, (d) ->
                                      d.year))

      drawXAxis()
      drawDotFor(data, 'incidents', 10, 1)
      drawDotFor(data, 'casualties', 20, -2)

  render: ->
    getDataAndRender()
