'use strict'

class Axis
  utils = new Utils
  svg = null

  isDateSelectedEvent = (dateClass, dateState) ->
    dateClass  == dateState

  setSvg: (axisProperties) ->
    svg = d3.select('body .dates-container .xaxis-container .' + axisProperties.axisClass)
            .append('svg')
            .attr('class', 'xaxis')
            .attr('width', axisProperties.width)
            .attr('height', axisProperties.height)
            .append('g')

  getSvg: ->
    svg

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
                        clickedDateClasses = d3.event.target.classList

                        return if _.includes(clickedDateClasses, 'fix-unhighlight')

                        dateClass = clickedDateClasses[0].replace('time-', '')
                        eventsManager.shouldFixDate(dateClass, axisProperties.axisClass))
       .on('mouseover', ->
                        if isDateSelectedEvent(axisProperties.axisClass, eventsManager.getDateState())
                          dateClasses = d3.event.target.classList
                          eventsManager.shouldHighlight(dateClasses))
       .on('mouseout', ->
                        if isDateSelectedEvent(axisProperties.axisClass, eventsManager.getDateState())
                          dateClasses = d3.event.target.classList
                          eventsManager.shouldUnhighlight(dateClasses))
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

  translateAxis: (timeClass) ->
    labels = d3.selectAll(".xaxis-container .timeaxis.#{timeClass} .x.axis .tick text")[0]

    d3.select(textLabel)
      .attr('class', (tl) ->
                      timeContent = utils.getFormattedDate(tl, timeClass)
                      @textContent = timeContent
                      @classList.value.replace(/time-\w*/g, "time-#{timeContent}")) for textLabel in labels
