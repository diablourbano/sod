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

  configureStatisticsBox = (dataSet) ->
    $('.statistics').addClass('visible')

    if !dataSet
      incidents = 0
      casualties = 0
    else
      incidents = dataSet.incidents ? 0
      casualties = dataSet.casualties ? 0

    $('.statistics ul li.incidents span.definition').text(incidents)
    $('.statistics ul li.casualties span.definition').text(casualties)

  displayStatisticsBox = (dateClasses, dataSet) ->
    left = $(".xaxis .time-#{dateClasses[0]}").parent().position().left - 35
    $('.statistics').css('left', "#{left}px")

    bottomPos = parseInt($(".xaxis .time-#{dateClasses[0]}").parents('.timeaxis').css('height').replace('px', ''))
    $('.statistics').css('bottom',  (bottomPos + 25) + 'px')

    configureStatisticsBox(dataSet)

  displayStatisticsByCountry = (countryClasses, dataSet, mousePosition) ->
    $country = $(".#{countryClasses.toString().replace(/\s/g, '.')}").position()

    $('.statistics').css('left', "#{mousePosition.x - 45}px")
    $('.statistics').css('top', "#{mousePosition.y - 80}px")
    $('.statistics').css('bottom', "0")

    configureStatisticsBox(dataSet)

  displaySplitStats = (dotClasses, dataSet) ->
    return if !dataSet

    dotClasses.push('dot', 'casualties') if !_.includes(dotClasses, 'dot')

    scrollElement = $(".timeaxis.#{currentDateState} .ps-scrollbar-x-rail").attr('style')
    deltaScroll = parseInt(scrollElement.split('; ')[0].split(': ')[1].replace('px', '')) if scrollElement

    xPosition = parseInt($(".time-#{dotClasses.join('.')}").attr('cx')) + 10 - deltaScroll
    xPosition = 0 if isNaN(xPosition)

    dotElements = {
      firstClasses: _.join(dotClasses, '.')
      secondClasses: _.join(dotClasses, '.')
      firstStat: 'casualties',
      secondStat: 'incidents'
    }

    if _.includes(dotClasses, 'incidents')
      dotElements.firstStat = 'incidents'
      dotElements.secondStat = 'casualties'

    dotElements.secondClasses = _.replace(dotElements.firstClasses, dotElements.firstStat, dotElements.secondStat)

    for position in ['first', 'second']
      dotPositionClasses = $(".time-#{dotElements["#{position}Classes"]}")

      return if dotPositionClasses.length == 0

      yPosition = $(".time-#{dotElements["#{position}Classes"]}").position().top - 60
      stat = dotElements["#{position}Stat"]

      $(".stats-#{stat}").css('top', "#{yPosition}px")
      $(".stats-#{stat}").css('left',  "#{xPosition - 27}px")
      $(".stats-#{stat}").addClass('visible')
      $(".stats-#{stat} ul li.#{stat} span.definition").text(dataSet[stat])

  loadBlurWindow = ->
    $('.main-container').addClass('loading')
    $('.overlay').addClass('visible')

  unloadBlurWindow = ->
    $('.main-container').removeClass('loading')
    $('.overlay').removeClass('visible')

  hideMenuBox = ->
    if $('.overlay .box').hasClass('visible')
      unloadBlurWindow()
      $('.overlay .box').removeClass('visible')

  loadInfo = ->
    localeToUse = moment.locale()
    $overlayBox = $('.overlay .box')

    $overlayBox.find('.headline').html(sod_locale[localeToUse].info.headline)
    $overlayBox.find('.related').html(sod_locale[localeToUse].info.related)
    $overlayBox.find('.footnote').html(sod_locale[localeToUse].info.footnote)

    $overlayBox.addClass('visible')

  constructor: (anEventsManager) ->
    eventsManager = anEventsManager

    configureScrollbars()
    setScrollListeners(eventsManager.getDateState())

  highlight: (dateClasses, dataSet) ->
    dataSet = {incidents: 0, casualties: 0} if !dataSet

    if $('.timeline-container').hasClass('collapsed')
      displaySplitStats(dateClasses, dataSet)
    else
      displayStatisticsBox(dateClasses, dataSet)

  unhighlight: (dataSet) ->
    $('.statistics').removeClass('visible')
    $('.statistics ul li.incidents span.definition').text('Loading...')
    $('.statistics ul li.casualties span.definition').text('Loading...')
    $('.stats-incidents').removeClass('visible')
    $('.stats-casualties').removeClass('visible')

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

  isLoading: ->
    loadBlurWindow()

    if localStorage.getItem('showInfoFirstTime') and !$('.overlay .box').hasClass('visible')
      $('.overlay .loading').addClass('visible')

    else
      loadInfo()
      localStorage.setItem('showInfoFirstTime', true)

  endLoading: ->
    $('.overlay .box').removeClass('visible') if $('.overlay .box').hasClass('visible')

    unloadBlurWindow()
    $('.overlay .loading').removeClass('visible')

  translate: ->
    localeToUse = moment.locale()

    $('.graph-slot p.selected-date span').text(eventsManager.getDateTextFragments().join(' '))
    $('.legend .for-incidents').text(sod_locale[localeToUse].incidents.label)
    $('.legend .for-casualties').text(sod_locale[localeToUse].casualties.label)

    $('.overlay .loading .label').text(sod_locale[localeToUse].loading.label)

    $(".menu .info .label").text(sod_locale[localeToUse].menu.info)

  highlightByCountry: (countryClasses, countrySet, mousePosition) ->
    displayStatisticsByCountry(countryClasses, countrySet, mousePosition)

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

  $('.menu .info').on('click', ->
    loadBlurWindow()
    loadInfo()
  )

  $(document).keyup((e) ->
     if e.keyCode == 27
       hideMenuBox()
  )

  $('.overlay .box .close').on('click', ->
    hideMenuBox()
  )

  $(window).resize( ->
                    eventsManager.shouldRedraw())
