'use strict'

class Utils

  height: window.innerHeight
  width: window.innerWidth
  timelineHeight: 350

  windowRatio: ->
    window.innerWidth / window.innerHeight

  sizeStyles: (aWidth = @width, aHeight = @height) ->
    aWidth += 'px' if aWidth != 'auto'
    aHeight += 'px' if aHeight != 'auto'
    [
      'width:' + aWidth,
      'height:' + aHeight
    ].join(';')

  getDateFragment: (date, dateState) ->
    if dateState == 'years'
      date.getFullYear() 
    else if dateState == 'months'
      date.getMonth() + 1
    else if dateState == 'days'
      date.getDate()

  getFormattedDate: (date, dateState) ->
    formatAxis = 'Y' if dateState == 'years'
    formatAxis = 'MMMM' if dateState == 'months'
    formatAxis = 'Do' if dateState == 'days'
    moment(date).format(formatAxis)

  printLog: (logToPrint) ->
    return
    console.log(logToPrint)
