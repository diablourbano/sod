'use strict'

class Days
  axis = new Axis
  xScale = null
  axisToDraw = null
  renderedAxis = null
  axisProperties = null
  isRendered = false

  eventsManager = null
  svg = null

  isThisDateState = ->
    eventsManager.getDateState() == axisProperties.axisClass

  constructor: (anEventsManager, someAxisProperties) ->
    axisProperties = someAxisProperties
    eventsManager = anEventsManager
    svg = axis.setSvg(axisProperties)

  getScale: ->
    xScale

  highlight: (dateClass) ->
    return if !isThisDateState()
    axis.toggleHighlight(svg, dateClass, true)

  unhighlight: (dateClass) ->
    return if !isThisDateState()
    axis.toggleHighlight(svg, dateClass, false)

  fixHighlight: (axisClass) ->
    return if axisClass != axisProperties.axisClass

    dateFragment = eventsManager.getDateTextFragments()[2]
    axis.fixHighlight(svg, dateFragment)

  exploreDate: ->
    return if isRendered
    @render()

  render: ->
    return if !isThisDateState()
    @remove()

    isRendered = true

    xScale = axis.setScale(axisProperties)
    axisToDraw = axis.setAxis(xScale)

    axis.configureAxisAndScale(xScale, axisToDraw, eventsManager.getDataSet(), eventsManager.getDateState())
    renderedAxis = axis.renderAxis(svg, axisToDraw, axisProperties, eventsManager)

  remove: ->
    renderedAxis.remove() if renderedAxis
