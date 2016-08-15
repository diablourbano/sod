'use strict'

class Map

  utils = new Utils
  eventsManager = null
  svg = null

  dateStates = ['years', 'months', 'days']
  highlightingCountry = false

  timelineHeight = ->
    $('.dates-container .xaxis-container').height()

  setSvg = ->
    svg = d3.select('body .map-container.fixed')
            .append('div')
            .attr('class', 'world-map-container')
            .append('svg')
            .attr('class', 'world-map')
            .attr('viewBox', '0 0 1000 730')
            .attr('style', 'max-height: ' + (utils.height - timelineHeight()) + 'px;')

  projection = d3.geo.mercator()
                 .translate([500, 500])

  path = d3.geo.path()
           .projection(projection)


  highlightCountryStats = (callback) ->
    countryClasses = d3.event.target.classList

    return if _.indexOf(countryClasses, 'years') == -1

    axisClass = _.last(countryClasses)
    dateState = eventsManager.getDateState()
    previousAxisIndex = dateStates.indexOf(dateState) - 1

    return if axisClass != dateStates[previousAxisIndex] and !(axisClass == dateState == 'days')

    callback(countryClasses[1])

  renderWith = (datum) ->
    configureMapPosition()

    svg.selectAll('.country')
       .data(datum.features)
       .enter()
       .append('path')
       .attr('class', (data) ->
                      'country ' + data.id)
       .on('mouseover', ->
                        left = d3.event.pageX
                        bottom = d3.event.pageY
                        bottomPos = bottom + (((bottom * 730) / 816) / 2)

                        console.log(bottomPos)

                        d3.select('.statistics')
                          .style('left', left + 'px')
                          .style('bottom', bottomPos + 'px')

                        highlightCountryStats((countryClass) ->
                            highlightingCountry = true
                            eventsManager.shouldHighlightBasedOnCountry(countryClass)))
       .on('mouseout', ->
                        highlightCountryStats((countryClass) ->
                            eventsManager.shouldUnhighlightBasedOnCountry(countryClass)
                            highlightingCountry = false))
       .attr('d', path)

  configureMapPosition = ->
    return if utils.windowRatio() >= 1

    mapContainerHeight = parseInt(d3.select('.world-map-container')
                                    .style('width')
                                    .replace('px', ''))

    topPosition = (mapContainerHeight / 2) - (utils.height / 2)
    topPosition *= -1 if topPosition < 0

    d3.select('.world-map-container').attr('style', 'margin-top: ' + topPosition + 'px;')

  constructor: (anEventsManager) ->
    eventsManager = anEventsManager
    setSvg()

  highlight: (dataClass, dataSet) ->
    return if highlightingCountry

    d3.select('.country.' + country.country)
      .classed('highlight', true) for country in dataSet.countries

  unhighlight: (dataClass, dataSet) ->
    return if highlightingCountry

    d3.select('.country.' + country.country)
        .classed('highlight', false) for country in dataSet.countries

  unfixHighlight: (axisClass) ->
    axisIndex = dateStates.indexOf(axisClass)
    (svg.selectAll('.country.' + dateStates[classToRemove])
        .classed(dateStates[classToRemove], false)) for classToRemove in [axisIndex..2]

  fixHighlight: (axisClass, dataSet) ->
    svg.select('.country.' + country.country)
       .classed(axisClass, true) for country in dataSet.countries


  exploreDate: () ->
    svg.attr('style', 'max-height: ' + (utils.height - timelineHeight()) + 'px;')

  render: (callback) ->
    utils.printLog('{"listener.render()": "map function not implemented"}')

  draw: (callback) ->
    d3.json "map.json", (error, world) ->
      return console.error(error) if error

      datum = topojson.feature(world, world.objects.world_map)
      renderWith(datum)
      callback()

  remove: (dateStatesToRemove) ->
    utils.printLog('{"listener.remove()": "map function not implemented"}')

  redraw: ->
    configureMapPosition()
    svg.attr('style', 'max-height: ' + (utils.height - timelineHeight()) + 'px;')
