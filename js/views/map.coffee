'use strict'

class Map

  utils = new Utils
  sizeConstant = 15
  height = utils.height - sizeConstant
  width = utils.width - sizeConstant
  ratio = width/height
  baseRatio = 960/620
  fixHighlight = false

  proportionalTo = (comparedValue)->
    (ratio * comparedValue) / baseRatio

  alignTopBasedOn = ->
    top = switch
            when ratio > 1.8 then 150
            when ratio > 1.5 then 190
            else 160

  whatScaleToUse = ->
    scale = switch
              when ratio > 1.8 then 170
              when ratio > 1.7 then 200
              when ratio > 1.4 then 210
              else 230

  mapProperties = {
                    top: proportionalTo(alignTopBasedOn())
                    width: width,
                    height: height,
                    scale: proportionalTo(whatScaleToUse())
                  }

  svg = d3.select('body .map-container.fixed')
          .attr('style', utils.sizeStyles(mapProperties.width,
                                    mapProperties.height))
          .append('svg')
          .attr('class', 'world-map')
          .attr('width', mapProperties.width)
          .attr('height', mapProperties.height)

  projection = d3.geo.mercator()
                 .scale(mapProperties.scale)
                 .translate([mapProperties.width/2,
                             (mapProperties.height/2) +
                              mapProperties.top])

  path = d3.geo.path()
           .projection(projection)

  renderWith = (datum) ->
    svg.selectAll('.country')
       .data(datum.features)
       .enter()
       .append('path')
       .attr('class', (data) ->
                      'country ' + data.id)
       .attr('d', path)

  getMapDataAndRender = (callback) ->
    d3.json "map.json", (error, world) ->
      return console.error(error) if error

      datum = topojson.feature(world, world.objects.world_map)
      renderWith(datum)
      callback()

  shouldFixedHighlightsCountries: ->
    fixHighlight = true

  shouldHighlightCountry: (dataSet) ->
    d3.select('.country.' + country)
        .classed('highlight', true) for country in dataSet.countries

  shouldUnhighlightCountry: (dataSet) ->
    if !fixHighlight
      d3.select('.country.' + country)
          .classed('highlight', false) for country in dataSet.countries

  render: (callback) ->
    getMapDataAndRender(callback)
