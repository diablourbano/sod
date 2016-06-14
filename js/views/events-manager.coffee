'use strict'

class EventsManager
  listeners = []
  dateState = 'years'
  dateStates = ['years', 'months', 'days']
  gtObjects = { years: [], months: [], days: [] }
  selectedDate = { 'years': null, 'months': '01', 'days': '01'  }
  dateTextFragments = []

  parseDate = d3.time.format('%Y-%m-%d').parse

  dataSetByDate = (dateClass) ->
    date = setSelectedDate(dateClass)
    dataSetIndex = _.findIndex(gtObjects[dateState], (obj) ->
                                          obj.date.getTime() == date.toDate().getTime())
    gtObjects[dateState][dataSetIndex]

  setSelectedDate = (dateClass) ->
    dateClass = '0' + dateClass if dateClass.length == 1
    selectedDate[dateState] = dateClass
    moment(_.values(selectedDate).join(' '), 'YYYY MMMM DD')

  shouldTransitionData = (self, callback) ->
    if dateState == 'months' or dateState == 'days'
      self.getData( ->
        callback())

    else
      callback()

  setDateTextFragments = (dateClass, dateValue) ->
    dateClass = dateClass.trim()
    dateText = $('.graph-slot p.selected-date').text().trim()
    
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

  revertDateState = (axisClass) ->
    return if dateState == 'years'

    indexOfDateState = dateStates.indexOf(axisClass)
    dateState = dateStates[indexOfDateState - 1]

  dateClassWithouthDecoration = (dateClass) ->
    dateClass = dateClass.replace(/(st|nd|rd|th)/, '') if dateClass.match(/(st|nd|rd|th)/) != null
    dateClass

  getDateTextFragments: ->
    dateTextFragments

  addListener: (listener) ->
    listeners.push(listener) if listeners.indexOf(listener) == -1

  shouldHighlight: (dateClass) ->
    dateClass = dateClassWithouthDecoration(dateClass)
    dataSet = dataSetByDate(dateClass)
    listener.highlight(dateClass, dataSet) for listener in listeners
    console.log(selectedDate)

  shouldUnhighlight: (dateClass) ->
    dateClass = dateClassWithouthDecoration(dateClass)
    dateClass = dateClass.replace(/(st|nd|rd|th)/, '') if dateClass.match(/(st|nd|rd|th)/) != null
    dataSet = dataSetByDate(dateClass)
    listener.unhighlight(dateClass, dataSet) for listener in listeners

  shouldFixDate: (dateClass, axisClass) ->
    date = dateClassWithouthDecoration(dateClass)
    dataSet = dataSetByDate(date)

    existDateFragment = dateTextFragments.indexOf(dateClass)

    if existDateFragment > -1
      fragmentsToRemove = []
      dateState = dateStates[existDateFragment]

      (dateTextFragments[fragment] = null
      fragmentsToRemove.push(dateStates[fragment + 1]) if fragment < 2) for fragment in [existDateFragment..2]

      (listener.unfixHighlight(axisClass)
      listener.remove(fragmentsToRemove)) for listener in listeners

    else
      setDateTextFragments(dateClass, dateClass)

      (listener.unhighlight(dateClass, dataSet)
      listener.fixHighlight(axisClass, dataSet)) for listener in listeners

      setNextDateState(axisClass)

    @shouldExploreDate()

  shouldExploreDate: ->
    shouldTransitionData(@, ->
      listener.exploreDate() for listener in listeners
    )

  shouldRender: ->
    listener.render() for listener in listeners

  getDataSet: ->
    gtObjects[dateState]

  getDateState: ->
    dateState

  getData: (callback) ->
    d3.json 'data_sample_' + dateState + '.json', (error, data) ->
      return console.error(error) if error

      data.forEach( (d) ->
        d.date = parseDate(d.date)
      )

      gtObjects[dateState] = data
      callback()
