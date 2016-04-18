'use strict'

sizeConstant = 5
height = window.innerHeight - sizeConstant
width = window.innerWidth - sizeConstant
ratio = width/height
baseRatio = 960/620

# originalMapProperties = {
#                           top: 130,
#                           width: 960,
#                           height: 620,
#                           scale: 150
#                         }

proportionalTo = (comparedValue)->
  (ratio * comparedValue) / baseRatio

alignTopBasedOn = ->
  top = switch
          when ratio > 1.8 then 150
          when ratio > 1.5 then 190
          else 160

whatScaleToUse = ->
  scale = switch
            when ratio > 1.8 then 180
            when ratio > 1.7 then 210
            when ratio > 1.5 then 220
            else 230

originalMapProperties = {
                          top: proportionalTo(alignTopBasedOn())
                          width: width,
                          height: height,
                          scale: proportionalTo(whatScaleToUse())
                        }

svg = d3.select('body .map-container')
        .attr('style', 'width: ' + originalMapProperties.width + 'px')
        .append('svg')
        .attr('class', 'world-map')
        .attr('width', originalMapProperties.width)
        .attr('height', originalMapProperties.height)

d3.json "map.json", (error, world) ->
  return console.error(error) if error

  datum = topojson.feature(world, world.objects.world_map)

  projection = d3.geo.mercator()
                 .scale(originalMapProperties.scale)
                 .translate([originalMapProperties.width/2,
                             (originalMapProperties.height/2) + 
                              originalMapProperties.top])

  path = d3.geo.path()
           .projection(projection)

  svg.selectAll('.country')
     .data(datum.features)
     .enter()
     .append('path')
     .attr('class', 'country')
     .attr('d', path)
