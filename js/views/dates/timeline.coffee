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
    dateClass = utils.getDateFragment(dataSet.date, eventsManager.getDateState())
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

  highlight: (dataSet) ->
    toggleHighlight(dataSet, true)

  unhighlight: (dataSet) ->
    toggleHighlight(dataSet, false)

  # exploreCountriesByDate: (date) ->
  #   listener.shouldFixedHighlightsCountries() for listener in listeners
  #   d3.select('.timeline-container').classed('collapsed', true)
  #   $('.timeline-container').slideUp('slow')
  #   d3.select('.dates-container .time-state-title').classed('shade', true)
  #   dateToDisplay = utils.getFormattedDate(date, dateState)
  #   $('.dates-container .time-state-title a').text(dateToDisplay)

  exploreDate: (date) ->
    renderGraph()

  render: ->
    renderGraph()
