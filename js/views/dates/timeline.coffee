'use strict'

class Timeline
  utils = new Utils
  dots = null
  axis = null
  eventsManager = null
  xScale = null

  lineChart = null

  svg = null
  timelineProperties = { height: 0, width: 0, x0: 0 }

  xHeight = 50

  setSvg = () ->
    svg = d3.select('body .dates-container .timeline-container')
           .attr('style', utils.sizeStyles(timelineProperties.width, 'auto'))
           .append('svg')
           .attr('class', 'timeline')
           .attr('width', timelineProperties.width)
           .attr('height', timelineProperties.height)
           .append('g')

  toggleHighlight = (dataSet, highlight) ->
    return if !dataSet
    dateClass = utils.getFormattedDate(dataSet.date, eventsManager.getDateState())
    svg.selectAll('.time-' + dateClass)
       .classed('highlight', highlight)

  configureScale = ->
    xScale.domain(d3.extent(eventsManager.getDataSet(), (d) ->
                                    d.date))

  renderGraph = () ->
    dots.remove()
    xScale = axis.getScale()
    configureScale()

    dotsElements = svg.selectAll('dot')
                      .data(eventsManager.getDataSet())
                      .enter()
    dots.draw(dotsElements, xScale)
    
  constructor: (anAxis, aTimelineProperties, anEventsManager) ->
    eventsManager = anEventsManager
    timelineProperties = aTimelineProperties

    setSvg()

    dotsProperties = { height: timelineProperties.height, xHeight: xHeight, x0: timelineProperties.x0 }
    dots = new Dots(@, dotsProperties, eventsManager)
    axis = anAxis

  getSvg: ->
    svg

  highlight: (dateClass, dataSet) ->
    toggleHighlight(dataSet, true)

  unhighlight: (dateClass, dataSet) ->
    toggleHighlight(dataSet, false)

  unfixHighlight: (axisClass) ->
    utils.printLog('{"listener.fixHighlight(dataSet)": "timeline function not implemented"}')

  fixHighlight: (axisClass) ->
    utils.printLog('{"listener.fixHighlight(dataSet)": "timeline function not implemented"}')

  exploreDate: (date) ->
    renderGraph()

  render: ->
    renderGraph()

  remove: ->
    utils.printLog('{"listener.remove()": "timeline function not implemented"}')

  redraw: ->
    utils.printLog('{"listener.redraw()": "timeline function not implemented"}')
