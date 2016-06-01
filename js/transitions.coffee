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
    console.log('{"listener.highlight(dataSet)": "transitions function not implemented"}')

  unhighlight: (dataSet) ->
    console.log('{"listener.unhighlight(dataSet)": "transitions function not implemented"}')

  exploreDate: () ->
    console.log('{"listener.exploreDate()": "transitions function not implemented"}')

  render: () ->
    console.log('{"listener.render()": "transitions function not implemented"}')

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

  $(window).resize( ->
                    eventsManager.shouldRender())
