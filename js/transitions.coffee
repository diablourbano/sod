'use strict'

class Transitions
  utils = new Utils
  eventsManager = null
  previousHeight = 0
  selectedDateTextFinished = false

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

  fixHighlight: (dataSet) ->
    return if selectedDateTextFinished

    selectedDate = utils.getFormattedDate(dataSet.date, eventsManager.getDateState())
    graphSlotText = $('.graph-slot p.selected-date').text()
    graphSlotText += ' ' if eventsManager.getDateState() != 'years'
    graphSlotText += selectedDate

    $('.graph-slot p.selected-date').text(graphSlotText)
    if eventsManager.getDateState() == 'days'
      selectedDateTextFinished = true

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
