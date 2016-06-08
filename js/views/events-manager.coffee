'use strict'

class EventsManager
  listeners = []
  dateState = 'years'
  dateStates = ['years', 'months', 'days']
  gtObjects = { years: [], months: [] }
  selectedDate = { 'years': null, 'months': '01', 'days': '01'  }
  dateTextFragments = null

  parseDate = d3.time.format('%Y-%m-%d').parse

  dataSetByDate = (dateClass) ->
    date = setSelectedDate(dateClass)
    dataSetIndex = _.findIndex(gtObjects[dateState], (obj) ->
                                          obj.date.getTime() == date.toDate().getTime())
    gtObjects[dateState][dataSetIndex]

  setSelectedDate = (dateClass) ->
    dateClass = dateClass.toString().replace('time-', '')
    dateClass = '0' + dateClass if dateClass.length == 1
    selectedDate[dateState] = dateClass
    moment(_.values(selectedDate).join(' '), 'YYYY MMMM DD')

  shouldTransitionData = (self, callback) ->
    if dateState == 'months' or dateState == 'days'
      self.getData( ->
        callback())

    else
      callback()

  setDateTextFragments = (dateClass) ->
    dateTextFragments = $('.graph-slot p.selected-date').text().split(' ')
    dateClass = dateClass.replace('time-', '')

    if dateClass.match(/^\d{4}$/) != null
      dateTextFragments[0] = dateClass
    else if dateClass.match(/^\D+$/) != null
      dateTextFragments[1] = dateClass
    else if dateClass.match(/^\d{1,2}\D{2}$/) != null
      dateTextFragments[2] = dateClass

  getDateTextFragments: ->
    dateTextFragments

  addListener: (listener) ->
    listeners.push(listener) if listeners.indexOf(listener) == -1

  shouldHighlight: (dateClass) ->
    listener.highlight(dateClass, dataSetByDate(dateClass)) for listener in listeners

  shouldUnhighlight: (dateClass) ->
    listener.unhighlight(dateClass, dataSetByDate(dateClass)) for listener in listeners

  shouldExploreDate: (dateClass) ->
    setDateTextFragments(dateClass)

    listener.unhighlight(dateClass, dataSetByDate(dateClass)) for listener in listeners
    listener.fixHighlight(dataSetByDate(dateClass)) for listener in listeners

    stateIndex = dateStates.indexOf(dateState)
    if stateIndex >= 0 and stateIndex < 2
      ++stateIndex

    dateState = dateStates[stateIndex]
    shouldTransitionData(@, ->
      listener.exploreDate() for listener in listeners
    )

  shouldRender: ->
    listener.render() for listener in listeners

  getDataSet: ->
    gtObjects[dateState]

  getDateState: ->
    dateState

  getSelectedDate: ->
    selectedDate

  getData: (callback) ->
    d3.json 'data_sample_' + dateState + '.json', (error, data) ->
      return console.error(error) if error

      data.forEach( (d) ->
        d.date = parseDate(d.date)
      )

      gtObjects[dateState] = data
      callback()

