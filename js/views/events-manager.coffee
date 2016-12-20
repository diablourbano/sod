'use strict'

class EventsManager
  dayEndingsFormat = /(st|nd|rd|th|er|ème)/
  listeners = []
  dateState = 'years'
  dateStates = ['years', 'months', 'days']
  timelineObjects = {}
  selectedDate = { 'years': null, 'months': 'January', 'days': '01'  }
  dateTextFragments = []
  urlManager = null
  utils = new Utils

  parseDate = d3.time.format('%Y-%m-%d').parse

  timelineObject = (object, datesToGet) ->
    dateToGet = datesToGet.shift()

    month = utils.monthIndex(dateToGet)
    dateToGet = month if month > 0

    if dateToGet.length > 0 and (isDay = dateToGet.match(/^\d{1,2}\D{2,3}$/)) != null
      dateToGet = parseInt(dateToGet.replace(/\D{2,3}$/, ''))

    if object[dateToGet] != undefined
      if datesToGet.length == 0
        return object[dateToGet]
      else
        timelineObject(object[dateToGet], datesToGet)
    else
      return null

  dataSetByDate = ->
    selectedDatesValues = _.values(selectedDate)
    selectedDatesValues[2] = dateClassWithDecoration(selectedDatesValues[2])

    datesToFilter = selectedDatesValues.slice(0, dateStates.indexOf(dateState) + 1)
    timelineObject(timelineObjects, datesToFilter)

  setSelectedDate = (aDateState, dateClass) ->
    dateClass = '0' + dateClass if dateClass and dateClass.length == 1
    selectedDate[aDateState] = dateClass

  setDateTextFragments = (dateClass) ->
    dateClass = dateClass.trim()
    dateText = $('.graph-slot p.selected-date span').text().trim()
    
    if dateText != ""
      dateTextFragments = dateText.split(' ')

    if dateClass.match(/^\d{4}$/) != null
      dateTextFragments[0] = dateClass
    else if dateClass.match(/^\D+$/) != null
      dateTextFragments[1] = dateClass
    else if dateClass.match(/^\d{1,2}\D{2,3}$/) != null
      dateTextFragments[2] = dateClass

  setNextDateState = (axisClass) ->
    return if dateState == 'days'

    indexOfDateState = dateStates.indexOf(axisClass)
    dateState = dateStates[indexOfDateState + 1]

  revertSelectedDate = ->
    setSelectedDate('years', null)
    setSelectedDate('months', 'January')
    setSelectedDate('days', '01')

  dateClassWithouthDecoration = (dateClass) ->
    dateClass = dateClass.replace(dayEndingsFormat, '') if dateClass.match(dayEndingsFormat) != null and dateState == 'days'
    dateClass

  dateClassWithDecoration = (dateClass) ->
    date = parseInt(dateClass)
    return moment.localeData().ordinal(date)

  datesUrl = (dateFragments) ->
    dates = []

    if dateFragments.length > 0
      dates.push(dateTextFragments[0]) if dateFragments[0]

      if dateFragments[1]
        month = dateFragments[1]

        if month
          month = utils.monthIndex(month).toString()
          month = "0#{month}" if month.length == 1
          dates.push(month)

    dates

  hasDataFor = (dateFragments) ->
    if _.isEmpty(timelineObjects)
      false

    else if dateFragments.length == 1
      # to avoid confusion, in this scenario [1] is the key, so it's january
      timelineObjects[dateFragments[0]][1] != undefined

    else if dateFragments.length == 2
      month = utils.monthIndex(dateFragments[1])
      timelineObjects[dateFragments[0]][month]['1st'] != undefined

    else
      true

  constructor: (anUrlManager) ->
    urlManager = anUrlManager

  getDateTextFragments: ->
    dateTextFragments

  addListener: (listener) ->
    listeners.push(listener) if listeners.indexOf(listener) == -1

  shouldHighlight: (dateClasses) ->
    classes = _.map(dateClasses, (dateClass) ->
      dateClass.replace('time-', '')
    )

    dateClassNoDecoration = dateClassWithouthDecoration(classes[0])
    setSelectedDate(dateState, dateClassNoDecoration)

    dataSet = dataSetByDate()
    listener.highlight(classes, dataSet) for listener in listeners

  shouldUnhighlight: (dateClasses) ->
    classes = _.map(dateClasses, (dateClass) ->
      dateClass.replace('time-', '')
    )

    dateClassNoDecoration = dateClassWithouthDecoration(classes[0])
    setSelectedDate(dateState, dateClassNoDecoration)

    dataSet = dataSetByDate()
    listener.unhighlight(classes, dataSet) for listener in listeners

  shouldFixDate: (dateClass, axisClass, dateToLoad=null, shouldGoToDate=true) ->
    existDateFragment = dateTextFragments.indexOf(dateClass)

    # this means we're unselecting date
    if existDateFragment > -1
      fragmentsToRemove = []
      dateState = dateStates[existDateFragment]

      (dateTextFragments[fragment] = null
      revertSelectedDate() if fragment == 0
      fragmentsToRemove.push(dateStates[fragment + 1]) if fragment < 2
      urlManager.goToDate(_.keys(selectedDate)[fragment], null)) for fragment in [existDateFragment..2]

      (listener.unfixHighlight(axisClass)
      listener.remove(fragmentsToRemove)) for listener in listeners

    # we want to fix to specified date
    else
      date = dateClassWithouthDecoration(dateClass)
      setSelectedDate(axisClass, date)
      dataSet = dataSetByDate()

      return if !dataSet

      setDateTextFragments(dateClass)

      (listener.unhighlight(dateClass, dataSet)
      listener.fixHighlight(axisClass, dataSet)) for listener in listeners

      urlManager.goToDate(axisClass, date) if shouldGoToDate == true

      setNextDateState(axisClass)

    @shouldExploreDate(dateToLoad)

  shouldExploreDate: (dateToLoad) ->
    @getData(->
      listener.exploreDate() for listener in listeners
    , dateToLoad)

  shouldRender: ->
    dateToLoad = urlManager.loadTimelineOnDate()

    @getData(->
      listener.render() for listener in listeners
    , dateToLoad)

  shouldRedraw: ->
    listener.redraw() for listener in listeners

  shouldTranslate: (previousLocale) ->
    parsedDate = moment(_.values(selectedDate).join('-'), 'YYYY-MMMM-DD', previousLocale)
    month = moment.months()[parsedDate.month()]

    setDateTextFragments(month)
    setSelectedDate('months', month)

    listener.translate() for listener in listeners

  shouldUnhighlightBasedOnCountry: (countryClasses) ->
    country = countryClasses[1]
    datesToFilter = dateTextFragments.slice(0, dateStates.indexOf(dateState))

    dateFragments = _.filter(dateTextFragments, (o) ->
                                                     return o?)

    countries = timelineObject(timelineObjects, dateFragments)
    countrySet = _.find(countries.countries, (o) ->
                                          return o.country == country)
    listener.unhighlightByCountry(dateState, countrySet) for listener in listeners

  shouldHighlightBasedOnCountry: (countryClasses) ->
    country = countryClasses[1]
    datesClasses = dateTextFragments.slice(0, dateStates.indexOf(dateState))
    dateFragments = _.filter(dateTextFragments, (o) ->
                                                     return o?)

    countries = timelineObject(timelineObjects, dateFragments)
    countrySet = _.find(countries.countries, (o) ->
                                          return o.country == country)

    datesClasses.unshift(countryClass) for countryClass in countryClasses
    listener.highlightByCountry(datesClasses, countrySet) for listener in listeners

  getDataSet: ->
    if selectedDate['years'] == null
      _.values(timelineObjects)
    else
      datesToFilter = _.values(selectedDate).slice(0, dateStates.indexOf(dateState))
      timelineObj = timelineObject(timelineObjects, datesToFilter)
      dataSet = _.pickBy(timelineObj, (value, key) ->
                                  keysToPick = ['date', 'casualties', 'incidents', 'countries']
                                  return _.indexOf(keysToPick, key) == -1)
      _.values(dataSet)

  getDateState: ->
    dateState

  getData: (callback, dateToLoad) ->
    dateFragments = _.filter(dateTextFragments, (textFragment) ->
                              textFragment != null )

    if dateFragments.length == 3
        callback()

        if dateToLoad and !dateTextFragments[2]
          @shouldFixDate(dateToLoad[dateState], dateState, dateToLoad, false) if dateToLoad[dateState]

    else

      if hasDataFor(dateFragments)
          callback()

          if dateToLoad and !dateTextFragments[2]
            @shouldFixDate(dateToLoad[dateState], dateState, dateToLoad, false) if dateToLoad[dateState]

      else
        datesUrlFragments = datesUrl(dateFragments)
        d3.json "#{cors_origin}/#{datesUrlFragments.join('/')}", (error, data) =>
          return printError(error) if error

          data.forEach( (d) ->
            d.date = parseDate(d.date)
            dateKey = utils.getFormattedDate(d.date, dateState)
            timelineObjects[dateKey] = d if dateState == 'years'

            if dateState == 'months'
              month = utils.monthIndex(dateKey)
              timelineObjects[datesUrlFragments[0]][month] = d

            if dateState == 'days'
              month = utils.monthIndex(dateTextFragments[1])
              timelineObjects[datesUrlFragments[0]][month][dateClassWithouthDecoration(dateKey)] = d if dateState == 'days'
          )

          callback()

          if dateToLoad and !dateTextFragments[2]
            @shouldFixDate(dateToLoad[dateState], dateState, dateToLoad, false) if dateToLoad[dateState]
