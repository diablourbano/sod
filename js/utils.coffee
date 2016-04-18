'use strict'

class Utils

  height: window.innerHeight
  width: window.innerWidth

  sizeStyles: (aWidth = @width, aHeight = @height) ->
    [
      'width:' + aWidth + 'px',
      'height:' + aHeight + 'px'
    ].join(';')
