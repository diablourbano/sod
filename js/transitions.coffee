'use strict'

class Transitions
  eventsManager = null
  previousHeight = 0

  adjustTabBasedOnTimeline = ->
    timelineHeight = parseInt($('.dates-container').css('height').replace('px', ''))
    deltaHeight = timelineHeight - previousHeight
    previousHeight = timelineHeight
    bottomPos = parseInt($('.graph-slot').css('bottom').replace('px', ''))
    $('.graph-slot').css('bottom', (bottomPos + deltaHeight) + 'px')

  constructor: (anEventsManager) ->
    eventsManager = anEventsManager

  highlight: (dataSet) ->
    console.log('{"listener.highlight(dataSet)": "map function not implemented"}')

  unhighlight: (dataSet) ->
    console.log('{"listener.unhighlight(dataSet)": "map function not implemented"}')

  exploreDate: () ->
    console.log('{"listener.exploreDate()": "map function not implemented"}')

  $('.graph-slot .slot').click( ->
    previousHeight = parseInt($('.dates-container').css('height').replace('px', ''))

    if !$('.timeline-container').hasClass('collapsed')
      $('.timeline-container').addClass('collapsed')
      $('.timeline-container').slideDown({ duration: 'slow', progress: (animation, progress, remainingMs) ->
                                                                          adjustTabBasedOnTimeline() })
    else
      $('.timeline-container').removeClass('collapsed')
      $('.timeline-container').slideUp({ duration: 'slow', progress: (animation, progress, remainingMs) ->
                                                                          adjustTabBasedOnTimeline() })
  )
