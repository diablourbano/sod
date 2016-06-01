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

  drawLineFor = (lineChart, dotType) ->
    timeline.getSvg().append('path')
       .datum(eventsManager.getDataSet())
       .attr('class', 'line-chart ' + dotType)
       .attr('d', lineChart)
       .attr('transform', 'translate(' + dotsProperties.x0 + ', 0)')

  drawDotFor = (dots, scale, dotType, radius, yScaleCallback) ->
    dots.append('circle')
        .attr('class', (d) ->
                        date = utils.getDateFragment(d.date, eventsManager.getDateState())
                        'time-' + date +
                        ' dot ' + dotType)
       .attr('r', radius)
       .attr('cx', (d) ->
                      scale(d.date))
       .attr('cy', (d) ->
                      yScaleCallback(d))
       .attr('transform', 'translate(' + dotsProperties.x0 + ', 0)')
       .on('click', (d) ->)
                    # timeline.exploreCountriesByDate(d.date))
       .on('mouseover', (d) ->
                        eventsManager.shouldHighlight(d3.event.target.classList[0]))
       .on('mouseout', (d) ->
                        eventsManager.shouldUnhighlight(d3.event.target.classList[0]))

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

    yScaleIncidents = d3.scale.linear().range([dotsProperties.height - 10, dotsProperties.height/2])
    yScaleCasualties = d3.scale.linear().range([dotsProperties.height - 10, 10])
  
  remove: ->
    dotsIncidents.remove() if dotsIncidents
    dotsCasualties.remove() if dotsCasualties
    lineIncidents.remove() if lineIncidents
    lineCasualties.remove() if lineCasualties

  draw: (dots, scale) ->
    configureYScales()

    lineIncidents = drawLineFor(configureLineChart(scale, yScaleIncidents, 'incidents'), 'incidents')
    dotsIncidents = drawDotFor(dots, scale, 'incidents', 5, (d) ->
                                                            yScaleIncidents(d.incidents))

    lineCasualties = drawLineFor(configureLineChart(scale, yScaleCasualties, 'casualties'), 'casualties')
    dotsCasualties = drawDotFor(dots, scale, 'casualties', 6, (d) ->
                                                            yScaleCasualties(d.casualties))
