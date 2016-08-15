'use strict'

class Dots
  utils = new Utils
  dotsIncidents = null
  dotsCasualties = null
  lineIncidents = null
  lineCasualties = null

  yScaleIncidents = null
  yScaleCasualties = null

  timeline = null
  eventsManager = null

  dotsProperties = { height: 0, xHeight: 0, x0: 0  }

  configureYScales = ->
    yScaleIncidents.domain([0, d3.max(eventsManager.getDataSet(), (d) ->
                                    d.incidents)])
    yScaleCasualties.domain([0, d3.max(eventsManager.getDataSet(), (d) ->
                                    d.casualties)])

  configureYAxisFor = (yScale) ->
    d3.svg.axis().scale(yScale)
                 .orient('left')
                 .tickSize(2)
                 .ticks(5)

  drawLineFor = (lineChart, dotType, yAxis) ->
    timeline.getSvg().append('path')
       .datum(eventsManager.getDataSet())
       .attr('class', 'line-chart ' + dotType)
       .attr('d', lineChart)
       .attr('transform', 'translate(' + dotsProperties.x0 + ', 0)')

    timeline.getSvg()
       .append('g')
       .attr('class', 'yaxis')
       .attr('transform', 'translate(40, 0)')
       .call(yAxis)

  drawDotFor = (dots, scale, dotType, radius, yScaleCallback) ->
    dots.append('circle')
        .attr('class', (d) ->
                        date = utils.getFormattedDate(d.date, eventsManager.getDateState())
                        'time-' + date +
                        ' dot ' + dotType)
       .attr('r', radius)
       .attr('cx', (d) ->
                      scale(d.date))
       .attr('cy', (d) ->
                      yScaleCallback(d))
       .attr('transform', 'translate(' + dotsProperties.x0 + ', 0)')
       .on('click', (d) ->
                        dateClass = d3.event.target.classList[0].replace('time-', '')
                        eventsManager.shouldFixDate(dateClass, eventsManager.getDateState()))
       .on('mouseover', (d) ->
                        dateClass = d3.event.target.classList[0].replace('time-', '')
                        eventsManager.shouldHighlight(dateClass))
       .on('mouseout', (d) ->
                        dateClass = d3.event.target.classList[0].replace('time-', '')
                        eventsManager.shouldUnhighlight(dateClass))

  configureLineChart = (xScale, yScale, scaleType) ->
     d3.svg.line()
       .x((d) ->
           xScale(d.date))
       .y((d) ->
           yScale(d[scaleType]))

  constructor: (aTimeline, aDotsProperties, anEventsManager) ->
    dotsProperties = aDotsProperties
    eventsManager = anEventsManager
    timeline = aTimeline

    verticalMiddle = dotsProperties.height / 2
    vertical = dotsProperties.height

    yScaleCasualties = d3.scale.linear().range([vertical - 20, verticalMiddle + 20])
    yScaleIncidents = d3.scale.linear().range([verticalMiddle - 20, 50])
  
  remove: ->
    dotsIncidents.remove() if dotsIncidents
    dotsCasualties.remove() if dotsCasualties
    lineIncidents.remove() if lineIncidents
    lineCasualties.remove() if lineCasualties

    # because of the yAxises we need to clean the svg child manually
    timeline.getSvg().selectAll('path').remove()

  draw: (dots, scale) ->
    configureYScales()
    radius = 6

    yAxisCasualties = configureYAxisFor(yScaleCasualties)
    yAxisIncidents = configureYAxisFor(yScaleIncidents)

    lineCasualties = drawLineFor(configureLineChart(scale, yScaleCasualties, 'casualties'), 'casualties', yAxisCasualties)
    dotsCasualties = drawDotFor(dots, scale, 'casualties', radius, (d) ->
                                                            yScaleCasualties(d.casualties))

    lineIncidents = drawLineFor(configureLineChart(scale, yScaleIncidents, 'incidents'), 'incidents', yAxisIncidents)
    dotsIncidents = drawDotFor(dots, scale, 'incidents', radius, (d) ->
                                                            yScaleIncidents(d.incidents))
