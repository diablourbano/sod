'use strict'

class Dots
  height = 0
  xHeight = 0
  x0 = 0

  utils = new Utils
  dotsIncidents = null
  dotsCasualties = null
  timeline = null

  drawDotFor = (dots, scale, dotType, radius, cyK, dateState) ->
    dots.append('circle')
        .attr('class', (d) ->
                        date = utils.getDateFragment(d.date, dateState)

                        'dot ' + dotType +
                        ' time-' + date)
       .attr('r', (d) ->
                      d[dotType]/radius)
       .attr('cx', (d) ->
                      scale(d.date))
       .attr('cy', (height / 2) +
                   (xHeight * cyK))
       .attr('transform', 'translate(' + x0 + ')')
       .on('click', (d) ->
                    timeline.exploreCountriesByDate(d.date))
       .on('mouseover', (d) ->
                        timeline.highlightDate(utils.getDateFragment(d.date, dateState))

                        timeline.shouldHighlightCountry(d))
       .on('mouseout', (d) ->
                        timeline.unhighlightDate(utils.getDateFragment(d.date, dateState))

                        timeline.shouldUnhighlightCountry(d))

  constructor: (aTimeline, dotsProperties) ->
    timeline = aTimeline
    height = dotsProperties.height
    xHeight = dotsProperties.xHeight
    x0 = dotsProperties.x0
  
  remove: ->
    dotsIncidents.remove() if dotsIncidents
    dotsCasualties.remove() if dotsCasualties

  draw: (dots, scale, dateState) ->
    dotsIncidents = drawDotFor(dots, scale, 'incidents',  10, 0, dateState)
    dotsCasualties = drawDotFor(dots, scale, 'casualties', 20, -2, dateState)
