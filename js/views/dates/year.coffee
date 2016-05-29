'use strict'

class Timeline

  dots = null
  axis = null

  listeners = []

  xScale = null
  xAxis = null
  renderedAxis = null
  svg = null

  gtObjects = { years: [], months: [] }

  utils = new Utils
  height = utils.timelineHeight
  width = utils.width

  xHeight = 50
  x0 = 20

  dateStates = ['years', 'months', 'days']
  dateState = 'years'

  parseDate = d3.time.format('%Y-%m-%d').parse

  setSvg = () ->
    svg = d3.select('body .dates-container .timeline-container')
           .attr('style', utils.sizeStyles(width, 'auto'))
           .append('svg')
           .attr('class', 'timeline')
           .attr('width', width)
           .attr('height', height)
           .append('g')

  transitionToView = ->
    if dateState == 'months' or dateState == 'days'
      getDataAndRender( ->
        tweenTransition())

    else
      tweenTransition()

  tweenTransition = ->
    renderedAxis.transition()
                .duration(60)
                .tween('axis', ->
                                 ->
                                   renderGraph())

  renderGraph = () ->
    dots.remove()

    axis.remove()
    renderedAxis = axis.drawAxis(svg, gtObjects[dateState], dateState)

    dotsElements = svg.selectAll('dot')
                      .data(gtObjects[dateState])
                      .enter()
    dots.draw(dotsElements, xScale, dateState)

  getDataAndRender = (callback) ->
    d3.json 'data_sample_' + dateState + '.json', (error, data) ->
      return console.error(error) if error

      data.forEach( (d) ->
        d.date = parseDate(d.date)
      )

      gtObjects[dateState] = data
      callback()

  constructor: ->
    setSvg()

    dotsProperties = { height: height, xHeight: xHeight, x0: x0 }
    dots = new Dots(@, dotsProperties)

    axisProperties = { width: width, height: (height), x0: x0 }
    axis = new Axis(@, axisProperties)

    xAxis = axis.getAxis()
    xScale = axis.getScale()

  addListener: (listener) ->
    listeners.push(listener) if listeners.indexOf(listener) == -1

  highlightDate: (dateClass) ->
    dateClass = dateClass.toString().replace('time-', '')
    d3.selectAll('.time-' + dateClass)
      .classed('highlight', true)
    d3.select('.statistics').classed('visible', true)

  unhighlightDate: (dateClass) ->
    dateClass = dateClass.toString().replace('time-', '')
    d3.selectAll('.time-' + dateClass)
      .classed('highlight', false)
    d3.select('.statistics').classed('visible', false)

  shouldHighlightCountry: (dataSet) ->
    listener.shouldHighlightCountry(dataSet) for listener in listeners

  shouldUnhighlightCountry: (dataSet) ->
    listener.shouldUnhighlightCountry(dataSet) for listener in listeners

  exploreCountriesByDate: (date) ->
    listener.shouldFixedHighlightsCountries() for listener in listeners
    d3.select('.timeline-container').classed('collapsed', true)
    $('.timeline-container').slideUp('slow')
    d3.select('.dates-container .time-state-title').classed('shade', true)
    dateToDisplay = utils.getFormattedDate(date, dateState)
    $('.dates-container .time-state-title a').text(dateToDisplay)

  exploreDate: (date) ->
    d3.select('.dates-container .time-state-title').classed('shade', true)
    dateToDisplay = utils.getFormattedDate(date, dateState)
    $('.dates-container .time-state-title a').text(dateToDisplay)

    stateIndex = dateStates.indexOf(dateState)
    if stateIndex >= 0 and stateIndex < 2
      stateIndex++

    dateState = dateStates[stateIndex]
    transitionToView()

  render: ->
    getDataAndRender( ->
                        renderGraph())
