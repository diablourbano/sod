'use strict'

class UrlManager
  utils = new Utils
  selectedDate = {years: null, months: null, days: null}

  maximumDayFor = (dateFragments) ->
    switch parseInt(dateFragments[1])
      when 1,3,5,7,8,10,12
        return 31
      when 2
        if (_.endsWith(dateFragments[0], '00') and parseInt(dateFragments[0])%400 == 0) or parseInt(dateFragments[0])%4 == 0
          return 28
        else
          return 29
      else
        return 30

  formattedDateFromUrl = (dateFragments) ->
    date = moment().year(parseInt(dateFragments[0]))
    date.month(parseInt(dateFragments[1]) - 1) if dateFragments[1] and dateFragments[1] != ''
    date.date(parseInt(dateFragments[2])) if dateFragments[2] and dateFragments[2] != ''

    date.format('Y MMMM Do').split(' ')

  getDateFragments = (dateString) ->
    dateFragments = dateString.split('/')
    dateArray = []

    if dateFragments[0].match(/^\d{4}/) != null and 1970 <= parseInt(dateFragments[0]) <= 2014
      dateArray[0] = dateFragments[0]

      if dateFragments[1] != undefined and dateFragments[1].match(/^\d{1,2}$/) != null and 1 <= parseInt(dateFragments[1]) <= 12
        dateFragments[1] = "0#{dateFragments[1]}" if dateFragments[1].length == 1
        dateArray[1] = dateFragments[1]

        if dateFragments[2] != undefined and dateFragments[2].match(/^\d{1,2}$/) != null and 1 <= parseInt(dateFragments[2]) <= maximumDayFor(dateFragments)
          dateFragments[2] = "0#{dateFragments[2]}" if dateFragments[2].length == 1
          dateArray[2] = dateFragments[2]

      return dateArray

    else
      return null

  setUrlHash = ->
    window.location.href = "#/#{_.filter(selectedDate, (obj) ->
                                                          return obj != null and obj != ''
                                                        ).join('/')}"

  loadTimelineOnDate: ->
    dateString = location.hash.replace('#/', '')

    return null if dateString.length == 0

    dateArray = getDateFragments(dateString)

    selectedDate = _.zipObject(_.keys(selectedDate), dateArray)
    setUrlHash()

    formattedDate = formattedDateFromUrl(dateArray)

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
    setUrlHash()
