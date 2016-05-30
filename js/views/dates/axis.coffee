'use strict'

class Axis
  utils = new Utils
  xScale = null
  axis = null
  renderedAxis = null
  axisProperties = { width: 0, height: 0, x0: 0 }

  eventsManager = null
  svg = null
  dataSet = null
  dateState = 'years'

  setSvg = ->
    svg = d3.select('body .dates-container .xaxis-container')
           .attr('style', utils.sizeStyles(axisProperties.width, 'auto'))
           .append('svg')
           .attr('class', 'xaxis')
           .attr('width', axisProperties.width)
           .attr('height', axisProperties.height)
           .append('g')

  setScale = ->
    xScale = d3.time.scale().range([0, axisProperties.width - 50])

  setAxis = ->
    axis = d3.svg.axis()
             .scale(xScale)
             .tickSize(0)
             .tickPadding(5)
             .orient('bottom')

  configureAxisAndScale = ->
    dateObjects = dataSet
    xScale.domain(d3.extent(dateObjects, (d) ->
                                    d.date))

    axis.ticks(d3.time[dateState])
    axis.tickFormat((d) ->
                          utils.getFormattedDate(d, dateState))
    
  renderAxis = ->
    renderedAxis = svg.append('g')
       .attr('class', 'x axis')
       .attr('transform', 'translate(' + axisProperties.x0 + ', 0)')
       .on('click', ->
                    eventsManager.shouldExploreDate(d3.event.target.classList[0]))
       .on('mouseover', ->
                        eventsManager.shouldHighlight(d3.event.target.classList[0]))
       .on('mouseout', ->
                        eventsManager.shouldUnhighlight(d3.event.target.classList[0]))
       .call(axis)

    d3.select(textLabel)
      .attr('class', (tl) ->
                      'time-' + utils.getDateFragment(tl, dateState)) for textLabel in d3.selectAll('.x.axis .tick text')[0]

    renderedAxis

  toggleHighlight = (dataSet, highlight) ->
    dateClass = utils.getDateFragment(dataSet.date, dateState)
    d3.selectAll('.time-' + dateClass)
      .classed('highlight', highlight)
    d3.select('.statistics').classed('visible', highlight)

  configureFromEventsManager = ->
    dataSet = eventsManager.getDataSet()
    dateState = eventsManager.getDateState()

  constructor: (anEventsManager, someAxisProperties) ->
    axisProperties = someAxisProperties

    eventsManager = anEventsManager
    configureFromEventsManager()

    setSvg()
    setScale()
    setAxis()

  highlight: (dataSet) ->
    toggleHighlight(dataSet, true)

  unhighlight: (dataSet) ->
    toggleHighlight(dataSet, false)

  exploreDate: () ->
    renderedAxis.transition()
                .duration(60)
                .tween('axis', =>
                                 =>
                                   configureFromEventsManager()
                                   @render())

  render: ->
    @remove()
    configureAxisAndScale()
    renderAxis()

  remove: ->
    renderedAxis.remove() if renderedAxis
