'use strict'

class Axis
  utils = new Utils
  width = 0
  height = 0
  x0 = 0
  xScale = null
  axis = null
  renderedAxis = null
  timeline = null

  configureAxisAndScale = (dateObjects, dateState)->
    xScale.domain(d3.extent(dateObjects, (d) ->
                                    d.date))

    axis.ticks(d3.time[dateState])
    axis.tickFormat((d) ->
                          formatAxis = 'Y' if dateState == 'years'
                          formatAxis = 'MMMM' if dateState == 'months'
                          moment(d).format(formatAxis))
    
  renderAxis = (svg, dateState) ->
    renderedAxis = svg.append('g')
       .attr('class', 'x axis')
       .attr('transform', 'translate(' +
                              x0 + ',' +
                              (height - 50) + ')')
       .on('click', ->
                    timeline.exploreDate())
       .on('mouseover', ->
                        timeline.highlightDate(event.target.classList[0]))
       .on('mouseout', ->
                        timeline.unhighlightDate(event.target.classList[0]))
       .call(axis)

    d3.select(textLabel)
      .attr('class', (tl) ->
                      'time-' + utils.getDateFragment(tl, dateState)) for textLabel in d3.selectAll('.x.axis .tick text')[0]
    renderedAxis

  constructor: (aTimeline, axisProperties) ->
    timeline = aTimeline
    width = axisProperties.width
    height = axisProperties.height
    x0 = axisProperties.x0

    @setScale()
    @setAxis()

  setScale: ->
    xScale = d3.time.scale().range([0, width - 50])

  getScale: ->
    xScale

  setAxis: ->
    axis = d3.svg.axis()
             .scale(@getScale(xScale))
             .tickSize(1.5)
             .tickPadding(15)
             .orient('bottom')

  getAxis: ->
    axis

  drawAxis: (svg, dataSet, dateState)->
    configureAxisAndScale(dataSet, dateState)
    renderAxis(svg, dateState)

  remove: ->
    renderedAxis.remove() if renderedAxis
