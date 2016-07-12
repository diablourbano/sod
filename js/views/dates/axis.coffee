'use strict'

class Axis
  utils = new Utils

  isDateSelectedEvent = (dateClass) ->
    dateClass  == eventsManager.getDateState()

  setSvg: (axisProperties) ->
    d3.select('body .dates-container .xaxis-container .' + axisProperties.axisClass)
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
                        dateClass = d3.event.target.classList[0].replace('time-', '')
                        eventsManager.shouldFixDate(dateClass, axisProperties.axisClass))
       .on('mouseover', ->
                        top = d3.event.pageX
                        d3.select('.statistics')
                          .style('left', top + 'px')

                        if isDateSelectedEvent(axisProperties.axisClass)
                          dateClass = d3.event.target.classList[0].replace('time-', '')
                          eventsManager.shouldHighlight(dateClass))
       .on('mouseout', ->
                        if isDateSelectedEvent(axisProperties.axisClass)
                          dateClass = d3.event.target.classList[0].replace('time-', '')
                          eventsManager.shouldUnhighlight(dateClass))
       .call(axis)

    labels = d3.selectAll('.xaxis-container .timeaxis.' + axisProperties.axisClass + ' .x.axis .tick text')[0]

    d3.select(textLabel)
      .attr('class', (tl) ->
                      'time-' + utils.getFormattedDate(tl, eventsManager.getDateState())) for textLabel in labels

    renderedAxis

  toggleHighlight: (svg, dateClass, highlight) ->
    svg.selectAll('.time-' + dateClass)
      .classed('highlight', highlight)

  unfixHighlight: (svg, axisClass) ->
    svg.selectAll('.tick text')
       .classed('fix-unhighlight', false)

    svg.selectAll('.tick text')
       .classed('fix-highlight', false)


  fixHighlight: (svg, axisClass, dateClassFragment) ->
    alreadySelected = svg.select('.tick text.fix-highlight.time-' + dateClassFragment)

    @unfixHighlight(svg, axisClass)

    if alreadySelected.empty()
      svg.selectAll('.tick text')
         .classed('fix-unhighlight', true)

      svg.select('.tick text.time-' + dateClassFragment)
         .classed('fix-unhighlight', false)
         .classed('fix-highlight', true)
