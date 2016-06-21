'use strict'

class UrlManager
  utils = new Utils
  selectedDate = {years: null, months: null, days: null}

  formattedDateFromUrl = (dateFragments) ->
    date = moment().year(parseInt(dateFragments[0]))
    date.month(parseInt(dateFragments[1]) - 1) if dateFragments[1] and dateFragments[1] != ''
    date.date(parseInt(dateFragments[2])) if dateFragments[2] and dateFragments[2] != ''

    date.format('Y MMMM Do').split(' ')

  loadTimelineOnDate: ->
    dateFragments = location.hash.replace('#/', '')

    return null if dateFragments.length == 0

    dateFragments = dateFragments.split('/')

    selectedDate = _.zipObject(_.keys(selectedDate), dateFragments)

    formattedDate = formattedDateFromUrl(dateFragments)

    dateToRender = selectedDate
    dateToRender['years'] = formattedDate[0]
    dateToRender['months'] = formattedDate[1] if dateToRender['months'] and dateToRender['months'] != ''
    dateToRender['days'] = formattedDate[2] if dateToRender['days'] and dateToRender['days'] != ''

    dateToRender

  goToDate: (dateFragment, date) ->
    if date
      date = (moment().month(date.toLowerCase()).month() + 1).toString() if dateFragment == 'months'
      date = "0#{date}" if date.length == 1

    selectedDate[dateFragment] = date
    window.location.href = "#/#{_.filter(selectedDate, (obj) ->
                                                          return obj != null and obj != ''
                                                        ).join('/')}"
