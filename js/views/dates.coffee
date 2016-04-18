'use strict'

class Dates

  utils = new Utils
  timelineHeight = 252

  render: ->
    d3.select('body .map-container.dummy')
      .attr('style', utils.sizeStyles(null, (utils.height - timelineHeight)))
