'use strict'

class Axis
  utils = new Utils

  setSvg: (axisProperties) ->
    d3.select('body .dates-container .xaxis-container .' + axisProperties.axisClass)
      .attr('style', utils.sizeStyles(axisProperties.width, 'auto'))
      .append('svg')
      .attr('class', 'xaxis')
      .attr('width', axisProperties.width)
      .attr('height', axisProperties.height)
      .append('g')

  setScale: (axisProperties) ->
    d3.time.scale().range([0, axisProperties.width - 100])

  setAxis: (xScale) ->
    d3.svg.axis()
      .scale(xScale)
      .tickSize(0)
      .tickPadding(5)
      .orient('bottom')

  configureAxisAndScale: (xScale, axis, dataSet, dateState)->
    xScale.domain(d3.extent(dataSet, (d) ->
                                    d.date))
    axis.ticks(d3.time[dateState])
    axis.tickFormat((d) ->
                          utils.getFormattedDate(d, dateState))
    
  renderAxis: (svg, axis, axisProperties, eventsManager) ->
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

    labels = d3.selectAll('.xaxis-container .timeaxis.' + axisProperties.axisClass + ' .x.axis .tick text')[0]

    d3.select(textLabel)
      .attr('class', (tl) ->
                      'time-' + utils.getDateFragment(tl, eventsManager.getDateState())) for textLabel in labels

    renderedAxis

  toggleHighlight: (svg, dataSet, dateState, highlight) ->
    dateClass = utils.getDateFragment(dataSet.date, dateState)
    svg.selectAll('.time-' + dateClass)
      .classed('highlight', highlight)
    d3.select('.statistics').classed('visible', highlight)

  fixHighlight: (svg, date, axisClass) ->
    timeaxis = d3.selectAll('.xaxis-container .timeaxis.' + axisClass + ' .x.axis .tick text')[0]

    d3.select(axis)
      .attr('fix-highlight', (ax) ->
                      highlight if ax == date) for axis in date
