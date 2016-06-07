'use strict'

class Days
  axis = new Axis
  xScale = null
  axisToDraw = null
  renderedAxis = null
  axisProperties = null

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

  highlight: (dataSet) ->
    return if !isThisDateState()
    axis.toggleHighlight(svg, dataSet, eventsManager.getDateState(), true)

  unhighlight: (dataSet) ->
    return if !isThisDateState()
    axis.toggleHighlight(svg, dataSet, eventsManager.getDateState(), false)

  fixHighlight: (dataSet) ->
    # return if !isThisDateState()
    # axis.fixHighlight(svg, dataSet.date, 'months')
    console.log('{"listener.fixHighlight(dataSet)": "days function not implemented"}')

  exploreDate: () ->
    @render()

  render: ->
    return if !isThisDateState()
    @remove()

    xScale = axis.setScale(axisProperties)
    axisToDraw = axis.setAxis(xScale)

    axis.configureAxisAndScale(xScale, axisToDraw, eventsManager.getDataSet(), eventsManager.getDateState())
    renderedAxis = axis.renderAxis(svg, axisToDraw, axisProperties, eventsManager)

  remove: ->
    renderedAxis.remove() if renderedAxis
