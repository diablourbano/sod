'use strict'

class Year

  utils = new Utils
  height = utils.timelineHeight - 22
  xHeight = 50
  xInitialPosition = 20
  width = utils.width - 60

  xScale = d3.time.scale().range([0, width - 50])

  parseYear = d3.time.format('%Y-%m-%d').parse

  xAxis = d3.svg.axis()
            .scale(xScale)
            .ticks(d3.time.years)
            .tickSize(1.5)
            .tickPadding(15)
            .orient('bottom')

  render: ->
    svg = d3.select('body .dates-container .year-container')
      .attr('style', utils.sizeStyles(width, 'auto'))
      .append('svg')
      .attr('class', 'timeline')
      .attr('width', width)
      .attr('height', height)
      .append('g')

    d3.json 'data_sample.json', (error, data) ->
      return console.error(error) if error

      data.forEach( (d) ->
        d.year = parseYear(d.year + '-01-01')
      )

      xScale.domain(d3.extent(data, (d) ->
                                      d.year))

      svg.append('g')
         .attr('class', 'x axis')
         .attr('transform', 'translate(' +
                                xInitialPosition + ',' +
                                (height - xHeight) + ')')
         .call(xAxis)

      svg.selectAll('dot')
         .data(data)
         .enter()
         .append('circle')
         .attr('class', (d) ->
                            console.log 'jjajaaj'
                            'dot incidents time-' + d.year.getFullYear())
         .attr('r', (d) ->
                        d.incidents/10)
         .attr('cx', (d) ->
                        xScale(d.year))
         .attr('cy', (height / 2) + xHeight + 40)
         .attr('transform', 'translate(' + xInitialPosition + ')')

      svg.selectAll('dot')
         .data(data)
         .enter()
         .append('circle')
         .attr('class', 'dot casualties')
         .attr('r', (d) ->
                        d.casualties/20)
         .attr('cx', (d) ->
                        xScale(d.year))
         .attr('cy', (height / 2) - (xHeight * 2) + 40)
         .attr('transform', 'translate(' + xInitialPosition + ')')
