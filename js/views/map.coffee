'use strict'

class Map

  utils = new Utils
  eventsManager = null
  svg = null
  fixHighlight = false
  done = false

  timelineHeight = ->
    dateStates = ['years', 'months', 'days']
    (dateStates.indexOf(eventsManager.getDateState()) + 1) * 100

  setSvg = ->
    svg = d3.select('body .map-container.fixed')
            .append('div')
            .attr('class', 'world-map-container')
            .append('svg')
            .attr('class', 'world-map')
            .attr('viewBox', '0 0 1000 700')
            .attr('style', 'max-height: ' + (utils.height - timelineHeight()) + 'px;')

  projection = d3.geo.mercator()
                 .translate([500, 500])

  path = d3.geo.path()
           .projection(projection)

  renderWith = (datum) ->
    setSvg()
    configureMapPosition()

    svg.selectAll('.country')
       .data(datum.features)
       .enter()
       .append('path')
       .attr('class', (data) ->
                      'country ' + data.id)
       .attr('d', path)

  getMapDataAndRender = ->
    d3.json "map.json", (error, world) ->
      return console.error(error) if error

      datum = topojson.feature(world, world.objects.world_map)
      renderWith(datum)

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

  shouldFixedHighlightsCountries: ->
    fixHighlight = true

  highlight: (dataClass, dataSet) ->
    d3.select('.country.' + country)
      .classed('highlight', true) for country in dataSet.countries

  unhighlight: (dataClass, dataSet) ->
    if !fixHighlight
      d3.select('.country.' + country)
          .classed('highlight', false) for country in dataSet.countries

  unfixHighlight: (axisClass, dataSet) ->
    utils.printLog('{"listener.unfixHighlight(dataSet)": "map function not implemented"}')

  fixHighlight: (axisClass, dataSet) ->
    utils.printLog('{"listener.fixHighlight(dataSet)": "map function not implemented"}')

  exploreDate: () ->
    svg.attr('style', 'max-height: ' + (utils.height - timelineHeight()) + 'px;')

  render: ->
    return if done
    done = true
    getMapDataAndRender()

  remove: (dateStatesToRemove) ->
    utils.printLog('{"listener.remove()": "map function not implemented"}')

  redraw: ->
    configureMapPosition()
