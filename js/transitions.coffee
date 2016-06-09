'use strict'

class Transitions
  utils = new Utils
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

  fixHighlight: () ->
    $('.graph-slot p.selected-date').text(eventsManager.getDateTextFragments().join(' '))

  exploreDate: () ->
    @render()
    timelineHeight = parseInt($('.dates-container').css('height').replace('px', ''))
    $('.graph-slot').css('bottom', timelineHeight + 'px')

  render: () ->
    $('.xaxis-container .' + eventsManager.getDateState()).addClass('visible')

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

  $('.timeaxis').perfectScrollbar({
    theme: 'sod',
    suppressScrollY: true
  })
