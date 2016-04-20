'use strict'

class Year

  gtObjects = { years: [], months: [] }
  dotsIncidents = null
  dotsCasualties = null

  utils = new Utils
  height = utils.timelineHeight - 22
  width = utils.width

  xHeight = 50
  x0 = 20

  dateStates = ['years', 'months']
  dateState = 'years'

  xScale = d3.time.scale().range([0, width - 50])

  parseDate = d3.time.format('%Y-%m-%d').parse

  xAxis = d3.svg.axis()
            .scale(xScale)
            .tickSize(1.5)
            .tickPadding(15)
            .orient('bottom')

  svg = d3.select('body .dates-container .timeline-container')
    .attr('style', utils.sizeStyles(width, 'auto'))
    .append('svg')
    .attr('class', 'timeline')
    .attr('width', width)
    .attr('height', height)
    .append('g')

  getDateFragment = (date) ->
    if dateState == 'years'
      date.getFullYear() 
    else if dateState == 'months'
      date.getMonth()

  drawXAxis = svg.append('g')
                 .attr('class', 'x axis')
                 .attr('transform', 'translate(' +
                                        x0 + ',' +
                                        (height - xHeight) + ')')
                 .on('click', ->
                              stateIndex = dateStates.indexOf(dateState)
                              if stateIndex == 0
                                stateIndex++
                              else
                                stateIndex--

                              dateState = dateStates[stateIndex]
                              transitionToView())
                 .on('mouseover', ->
                                      d3.selectAll('.time-' + event.srcElement.textContent)
                                        .classed('highlight', true))
                 .on('mouseout', ->
                                      d3.selectAll('.time-' + event.srcElement.textContent)
                                        .classed('highlight', false))

  drawDotFor = (dotType, radius, cyK) ->
    svg.selectAll('dot')
       .data(gtObjects[dateState])
       .enter()
       .append('circle')
       .attr('class', (d) ->
                        date = getDateFragment(d.date)

                        'dot ' + dotType +
                        ' time-' + date)
       .attr('r', (d) ->
                      d[dotType]/radius)
       .attr('cx', (d) ->
                      xScale(d.date))
       .attr('cy', (height / 2) +
                   (xHeight * cyK) + 40)
       .attr('transform', 'translate(' + x0 + ')')
       .on('mouseover', (d) ->
                            date = getDateFragment(d.date)
                            d3.selectAll('.time-' + date)
                              .classed('highlight', true))
       .on('mouseout', (d) ->
                            date = getDateFragment(d.date)
                            d3.selectAll('.time-' + date)
                              .classed('highlight', false))

  getDataAndRender = (callback) ->
    d3.json 'data_sample_' + dateState + '.json', (error, data) ->
      return console.error(error) if error

      data.forEach( (d) ->
        d.date = parseDate(d.date)
      )

      gtObjects[dateState] = data
      callback()

  transitionToView = ->
    if dateState == 'months'
      getDataAndRender( ->
        tweenTransition())

    else
      tweenTransition()

  tweenTransition = ->
    drawXAxis.transition()
             .duration(60)
             .tween('axis', ->
                              ->
                                renderGraph())

  renderGraph = () ->
    dotsIncidents.remove() if dotsIncidents
    dotsCasualties.remove() if dotsCasualties

    xScale.domain(d3.extent(gtObjects[dateState], (d) ->
                                    d.date))

    xAxis.ticks(d3.time[dateState])
    xAxis.tickFormat((d) ->
                          formatAxis = 'Y' if dateState == 'years'
                          formatAxis = 'MMMM' if dateState == 'months'
                          moment(d).format(formatAxis))

    drawXAxis.call(xAxis)
    d3.select(textLabel)
      .attr('class', (tl) ->
                      'time-' + getDateFragment(tl)) for textLabel in d3.selectAll('.x.axis .tick text')[0]
    
    dotsIncidents = drawDotFor('incidents',  10, 1)
    dotsCasualties = drawDotFor('casualties', 20, -2)

  render: ->
    getDataAndRender( ->
                        renderGraph())
