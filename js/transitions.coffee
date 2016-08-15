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

  adjustTabBasedOnDatesContainer = ->
    timelineHeight = parseInt($('.dates-container').css('height').replace('px', ''))
    $('.graph-slot').css('bottom', "#{timelineHeight}px") if timelineHeight >= 10

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
    bottomPos = 80

    if ['years', 'months', 'days'].indexOf(dateClass) == -1
      bottomPos = parseInt($(".xaxis .time-#{dateClass}").parents('.timeaxis').css('height').replace('px', ''))
      $('.statistics').css('bottom',  (bottomPos + 25) + 'px')

    $('.statistics').addClass('visible')

    $('.statistics ul li.incidents span.definition').text(dataSet.incidents)
    $('.statistics ul li.casualties span.definition').text(dataSet.casualties)

  unhighlight: (dataSet) ->
    $('.statistics').removeClass('visible')
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

  $('.graph-slot .toggle-timeline').click( ->
    $(@).children('p').children('i').toggleClass('fa-chevron-down')
    $(@).children('p').children('i').toggleClass('fa-chevron-up')

    if $('.dates-container .xaxis-container').hasClass('collapsed')
      $('.dates-container .xaxis-container').removeClass('collapsed')
      $('.dates-container .xaxis-container').slideDown
                                      duration: 'slow'
                                      progress: (animation, progress, remainingMs) ->
                                                  adjustTabBasedOnDatesContainer()
                                                  eventsManager.shouldRedraw()
    else
      $('.dates-container .xaxis-container').addClass('collapsed')
      $('.dates-container .xaxis-container').slideUp
                                      duration: 'slow'
                                      progress: (animation, progress, remainingMs) ->
                                                  adjustTabBasedOnDatesContainer()
                                                  eventsManager.shouldRedraw()
  )

  $('.breadcrumb-back').click( ->
    axisClasses = ['years', 'months', 'days']

    dateFragments = $('.graph-slot p.selected-date span').text().trim().split(' ')
    axisIndex = dateFragments.length - 1

    eventsManager.shouldFixDate(dateFragments[axisIndex], axisClasses[axisIndex])
  )

  $('.graph-slot .slot').click( ->
    previousHeight = parseInt($('.dates-container').css('height').replace('px', ''))

    if $('.timeline-container').hasClass('collapsed')
      $('.timeline-container').removeClass('collapsed')
      $('.timeline-container').slideUp({ duration: 'slow', progress: (animation, progress, remainingMs) ->
                                                                          adjustTabBasedOnTimeline() })
    else
      $('.timeline-container').addClass('collapsed')
      $('.timeline-container').slideDown({ duration: 'slow', progress: (animation, progress, remainingMs) ->
                                                                          adjustTabBasedOnTimeline() })
  )

  $(window).resize( ->
                    eventsManager.shouldRedraw())
