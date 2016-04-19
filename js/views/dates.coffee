'use strict'

class Dates

  utils = new Utils
  xValues = (record) ->

                  
  render: ->
    d3.select('body .map-container.dummy')
      .attr('style', utils.sizeStyles(null, (utils.height - utils.timelineHeight)))


