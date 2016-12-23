'use strict'

class Years
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
    return if axisClass != axisProperties.axisClass

    axis.unfixHighlight(svg, axisClass)

  fixHighlight: (axisClass) ->
    return if axisClass != axisProperties.axisClass

    eventsManager.endLoading()

    dateFragment = eventsManager.getDateTextFragments()[0]
    axis.fixHighlight(svg, axisClass, dateFragment)

  exploreDate: ->
    utils.printLog('{"listener.exploreDate()": "years function not implemented"}')

  render: ->
    return if !isThisDateState()

    xScale = axis.setScale(axisProperties)
    axisToDraw = axis.setAxis(xScale)

    axis.configureAxisAndScale(xScale, axisToDraw, eventsManager.getDataSet(), eventsManager.getDateState())
    renderedAxis = axis.renderAxis(svg, axisToDraw, axisProperties, eventsManager)

  remove: (dateStatesToRemove) ->
    utils.printLog('{"listener.remove()": "years function not implemented"}')

  redraw: ->
    utils.printLog('{"listener.redraw()": "years function not implemented"}')

  translate: ->
    utils.printLog('{"listener.translate()": "years function not implemented"}')

  isLoading: ->
    utils.printLog('{"listener.isLoading()": "years function not implemented"}')

  endLoading: ->
    utils.printLog('{"listener.isLoading()": "years function not implemented"}')

  highlightByCountry: (countryClasses, countrySet, cursorPosition) ->
    utils.printLog('{"listener.highlightByCountry()": "years function not implemented"}')
