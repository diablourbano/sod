'use strict'

height = window.innerHeight
width = window.innerWidth

d3.select('body .map-container.dummy')
  .attr('style', sizeStyle(width, height))

yearCircle = d3.selectAll('body .dates-container .year-container .total-qty')
               .append('svg')
               .attr('width', 244)
               .attr('height', 216)

yearCircle.append('circle')
          .attr('cx', 122)
          .attr('cy', 128)
          .attr('r', 40)
