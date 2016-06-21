'use strict'

class Transitions
  utils = new Utils
  eventsManager = null
  previousHeight = 0

  dateStates = ['years', 'months', 'days']
  currentDateState = null

  adjustTabBasedOnTimeline = ->
    timelineHeight = parseInt($('.dates-container').css('height').replace('px', ''))
    deltaHeight = timelineHeight - previousHeight
    previousHeight = timelineHeight
    bottomPos = parseInt($('.graph-slot').css('bottom').replace('px', ''))
    $('.graph-slot').css('bottom', (bottomPos + deltaHeight) + 'px')

  resetGraphSlotPosition = ->
    timelineHeight = parseInt($('.dates-container').css('height').replace('px', ''))
    $('.graph-slot').css('bottom', timelineHeight + 'px')

  nextDateState = ->
    return if currentDateState == 'days'

    indexOfDateState = dateStates.indexOf(currentDateState)
    dateStates[indexOfDateState + 1]

  configureScrollbars = ->
    $('.timeaxis').perfectScrollbar({
      theme: 'sod',
      suppressScrollY: true
    })

    $('.timeline-container').perfectScrollbar({
      suppressScrollY: true
    })

  setScrollListeners = (dateState) ->
    currentDateState = dateState
    $('.timeaxis.' + currentDateState).on('ps-scroll-x', ->
      $('.timeline-container').scrollLeft($(@).scrollLeft())
    )

    $('.timeline-container').on('ps-scroll-x', ->
      $('.timeaxis.' + currentDateState).scrollLeft($(@).scrollLeft())
    )

  unsetScrollListeners = ->
    $('.timeaxis.' + currentDateState).off('ps-scroll-x')
    $('.timeline-container').off('ps-scroll-x')

  constructor: (anEventsManager) ->
    eventsManager = anEventsManager

    configureScrollbars()
    setScrollListeners(eventsManager.getDateState())

  highlight: (dateClass, dataSet) ->
    $('.statistics ul li.incidents span.definition').text(dataSet.incidents)
    $('.statistics ul li.casualties span.definition').text(dataSet.casualties)

  unhighlight: (dataSet) ->
    $('.statistics ul li.incidents span.definition').text('Loading...')
    $('.statistics ul li.casualties span.definition').text('Loading...')

  unfixHighlight: (axisClass) ->
    $('.graph-slot p.selected-date span').text(eventsManager.getDateTextFragments().join(' '))

    if $('.graph-slot p.selected-date span').text().trim() == ''
      $('.graph-slot p.selected-date').removeClass('visible')

    unsetScrollListeners()
    setScrollListeners(eventsManager.getDateState())

  fixHighlight: (axisClass) ->
    $('.graph-slot p.selected-date span').text(eventsManager.getDateTextFragments().join(' '))
    $('.graph-slot p.selected-date').addClass('visible')
    unsetScrollListeners()
    setScrollListeners(nextDateState())

  exploreDate: ->
    @render()
    resetGraphSlotPosition()

  render: ->
    $('.xaxis-container .' + eventsManager.getDateState()).addClass('visible')

  remove: (dateStatesToRemove) ->
    $('.xaxis-container .' + dateState).removeClass('visible') for dateState in dateStatesToRemove
    resetGraphSlotPosition()

  redraw: ->
    utils.printLog('{"listener.redraw()": "transitions function not implemented"}')

  $('.breadcrumb-back').click( ->
    axisClasses = ['years', 'months', 'days']

    dateFragments = $('.graph-slot p.selected-date span').text().trim().split(' ')
    axisIndex = dateFragments.length - 1

    eventsManager.shouldFixDate(dateFragments[axisIndex], axisClasses[axisIndex])
  )

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
                    eventsManager.shouldRedraw())
