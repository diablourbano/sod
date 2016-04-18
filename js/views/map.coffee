'use strict'

height = window.innerHeight
width = window.innerWidth

originalMapProperties = {
                          top: 130,
                          width: 960,
                          height: 620,
                          scale: 150
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
