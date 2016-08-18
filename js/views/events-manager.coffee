'use strict'

class EventsManager
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

  setDateTextFragments = (dateClass, dateValue) ->
    dateClass = dateClass.trim()
    dateText = $('.graph-slot p.selected-date span').text().trim()
    
    if dateText != ""
      dateTextFragments = dateText.split(' ')

    if dateClass.match(/^\d{4}$/) != null
      dateTextFragments[0] = dateValue
    else if dateClass.match(/^\D+$/) != null
      dateTextFragments[1] = dateValue
    else if dateClass.match(/^\d{1,2}\D{2}$/) != null
      dateTextFragments[2] = dateValue

  setNextDateState = (axisClass) ->
    return if dateState == 'days'

    indexOfDateState = dateStates.indexOf(axisClass)
    dateState = dateStates[indexOfDateState + 1]

  revertSelectedDate = ->
    setSelectedDate('years', null)
    setSelectedDate('months', 'January')
    setSelectedDate('days', '01')

  dateClassWithouthDecoration = (dateClass) ->
    dateClass = dateClass.replace(/(st|nd|rd|th)/, '') if dateClass.match(/(st|nd|rd|th)/) != null
    dateClass

  dateClassWithDecoration = (dateClass) ->
    date = parseInt(dateClass)

    if date == 1 and date != 11
      "#{date}st"
    else if date == 2 and date != 12
      "#{date}nd"
    else if date == 3 and date != 13
      "#{date}rd"
    else
      "#{date}th"
      

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

      setDateTextFragments(dateClass, dateClass)

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

  shouldUnhighlightBasedOnCountry: (country) ->
    datesToFilter = dateTextFragments.slice(0, dateStates.indexOf(dateState))

    dateFragments = _.filter(dateTextFragments, (o) ->
                                                     return o?)

    countries = timelineObject(timelineObjects, dateFragments)
    countrySet = _.find(countries.countries, (o) ->
                                          return o.country == country)
    listener.unhighlight(dateState, countrySet) for listener in listeners

  shouldHighlightBasedOnCountry: (country) ->
    datesToFilter = dateTextFragments.slice(0, dateStates.indexOf(dateState))

    dateFragments = _.filter(dateTextFragments, (o) ->
                                                     return o?)

    countries = timelineObject(timelineObjects, dateFragments)
    countrySet = _.find(countries.countries, (o) ->
                                          return o.country == country)
    listener.highlight(dateState, countrySet) for listener in listeners

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
    # first always brings all the years
    d3.json 'data_sample_' + dateState + '.json', (error, data) =>
      return printError(error) if error

      data.forEach( (d) ->
        d.date = parseDate(d.date)
        dateKey = utils.getFormattedDate(d.date, dateState)
        timelineObjects[dateKey] = d if dateState == 'years'
        timelineObjects[dateTextFragments[0]][dateKey] = d if dateState == 'months'
        timelineObjects[dateTextFragments[0]][dateTextFragments[1]][dateKey] = d if dateState == 'days'
      )

      callback()

      if dateToLoad != null and dateTextFragments[2] == undefined
        @shouldFixDate(dateToLoad[dateState], dateState, dateToLoad, false) if dateToLoad[dateState] != null and dateToLoad[dateState] != undefined and dateToLoad[dateState] != ''
