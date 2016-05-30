'use strict'

class Dots
  utils = new Utils
  dotsIncidents = null
  dotsCasualties = null
  timeline = null
  eventsManager = null

  dotsProperties = { height: 0, xHeight: 0, x0: 0  }

  drawDotFor = (dots, scale, dotType, radius, cyK) ->
    dots.append('circle')
        .attr('class', (d) ->
                        date = utils.getDateFragment(d.date, eventsManager.getDateState())
                        'time-' + date +
                        ' dot ' + dotType)
       .attr('r', (d) ->
                      d[dotType]/radius)
       .attr('cx', (d) ->
                      scale(d.date))
       .attr('cy', (dotsProperties.height / 2) +
                   (dotsProperties.xHeight * cyK))
       .attr('transform', 'translate(' + dotsProperties.x0 + ')')
       .on('click', (d) ->)
                    # timeline.exploreCountriesByDate(d.date))
       .on('mouseover', (d) ->
                        eventsManager.shouldHighlight(d3.event.target.classList[0]))
       .on('mouseout', (d) ->
                        eventsManager.shouldUnhighlight(d3.event.target.classList[0]))

  constructor: (aTimeline, aDotsProperties, anEventsManager) ->
    dotsProperties = aDotsProperties
    eventsManager = anEventsManager
    timeline = aTimeline
  
  remove: ->
    dotsIncidents.remove() if dotsIncidents
    dotsCasualties.remove() if dotsCasualties

  draw: (dots, scale) ->
    dotsIncidents = drawDotFor(dots, scale, 'incidents',  10, 0)
    dotsCasualties = drawDotFor(dots, scale, 'casualties', 20, -2)
