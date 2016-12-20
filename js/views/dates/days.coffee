'use strict'

class Days
  axis = new Axis
  xScale = null
  axisToDraw = null
  renderedAxis = null
  axisProperties = null

  eventsManager = null
  svg = null

  utils = new Utils

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

  unfixHighlight: (axisClass) ->
    utils.printLog('{"listener.redraw()": "days function not implemented"}')

  fixHighlight: (axisClass) ->
    utils.printLog('{"listener.redraw()": "days function not implemented"}')

  exploreDate: ->
    return if renderedAxis
    @render()

  render: ->
    return if !isThisDateState()

    xScale = axis.setScale(axisProperties)
    axisToDraw = axis.setAxis(xScale)

    axis.configureAxisAndScale(xScale, axisToDraw, eventsManager.getDataSet(), eventsManager.getDateState())
    renderedAxis = axis.renderAxis(svg, axisToDraw, axisProperties, eventsManager)

  remove: (dateStatesToRemove) ->
    return if dateStatesToRemove.indexOf(axisProperties.axisClass) == -1
    if renderedAxis
      renderedAxis.remove()
      renderedAxis = null

  redraw: ->
    utils.printLog('{"listener.redraw()": "days function not implemented"}')

  translate: ->
    axis.translateAxis('days')
