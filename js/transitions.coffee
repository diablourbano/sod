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

  resetGraphSlotPosition = ->
    timelineHeight = parseInt($('.dates-container').css('height').replace('px', ''))
    $('.graph-slot').css('bottom', timelineHeight + 'px')

  constructor: (anEventsManager) ->
    eventsManager = anEventsManager

  highlight: (dataSet) ->
    console.log('{"listener.highlight(dataSet)": "transitions function not implemented"}')

  unhighlight: (dataSet) ->
    console.log('{"listener.unhighlight(dataSet)": "transitions function not implemented"}')

  unfixHighlight: (axisClass) ->
    $('.graph-slot p.selected-date').text(eventsManager.getDateTextFragments().join(' '))

  fixHighlight: (axisClass) ->
    $('.graph-slot p.selected-date').text(eventsManager.getDateTextFragments().join(' '))

  exploreDate: ->
    @render()
    resetGraphSlotPosition()

  render: ->
    $('.xaxis-container .' + eventsManager.getDateState()).addClass('visible')

  remove: (dateStatesToRemove) ->
    $('.xaxis-container .' + dateState).removeClass('visible') for dateState in dateStatesToRemove
    resetGraphSlotPosition()

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
