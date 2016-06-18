'use strict'

class EventsManager
  listeners = []
  dateState = 'years'
  dateStates = ['years', 'months', 'days']
  gtObjects = { years: [], months: [], days: [] }
  selectedDate = { 'years': null, 'months': 'January', 'days': '01'  }
  dateTextFragments = []

  parseDate = d3.time.format('%Y-%m-%d').parse

  dataSetByDate = (dateClass) ->
    date = moment(_.values(selectedDate).join(' '), 'YYYY MMMM DD')
    dataSetIndex = _.findIndex(gtObjects[dateState], (obj) ->
                                          obj.date.getTime() == date.toDate().getTime())
    gtObjects[dateState][dataSetIndex]

  setSelectedDate = (aDateState, dateClass) ->
    dateClass = '0' + dateClass if dateClass and dateClass.length == 1
    selectedDate[aDateState] = dateClass

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

  revertSelectedDate = ->
    setSelectedDate('years', null)
    setSelectedDate('months', 'January')
    setSelectedDate('days', '01')

  dateClassWithouthDecoration = (dateClass) ->
    dateClass = dateClass.replace(/(st|nd|rd|th)/, '') if dateClass.match(/(st|nd|rd|th)/) != null
    dateClass

  getDateTextFragments: ->
    dateTextFragments

  addListener: (listener) ->
    listeners.push(listener) if listeners.indexOf(listener) == -1

  shouldHighlight: (dateClass) ->
    dateClassNoDecoration = dateClassWithouthDecoration(dateClass)
    setSelectedDate(dateState, dateClassNoDecoration)

    dataSet = dataSetByDate(dateClassNoDecoration)
    listener.highlight(dateClass, dataSet) for listener in listeners

  shouldUnhighlight: (dateClass) ->
    dateClassNoDecoration = dateClassWithouthDecoration(dateClass)
    setSelectedDate(dateState, dateClassNoDecoration)

    dataSet = dataSetByDate(dateClassNoDecoration)
    listener.unhighlight(dateClass, dataSet) for listener in listeners

  shouldFixDate: (dateClass, axisClass) ->
    existDateFragment = dateTextFragments.indexOf(dateClass)

    # this means we're unselecting date
    if existDateFragment > -1
      fragmentsToRemove = []
      dateState = dateStates[existDateFragment]

      (dateTextFragments[fragment] = null
      revertSelectedDate() if fragment == 0
      fragmentsToRemove.push(dateStates[fragment + 1]) if fragment < 2) for fragment in [existDateFragment..2]

      (listener.unfixHighlight(axisClass)
      listener.remove(fragmentsToRemove)) for listener in listeners

    # we want to fix to specified date
    else
      date = dateClassWithouthDecoration(dateClass)
      setSelectedDate(axisClass, date)
      dataSet = dataSetByDate(date)

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

  shouldRedraw: ->
    listener.redraw() for listener in listeners

  getDataSet: ->
    gtObjects[dateState]

  getDateState: ->
    dateState

  getData: (callback) ->
    d3.json 'data_sample_' + dateState + '.json', (error, data) ->
      return printLrror(error) if error

      data.forEach( (d) ->
        d.date = parseDate(d.date)
      )

      gtObjects[dateState] = data
      callback()
