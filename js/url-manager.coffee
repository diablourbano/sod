'use strict'

class UrlManager
  selectedDate = {years: null, months: null, days: null}

  goToDate: (dateFragment, date) ->
    if date
      date = (moment().month(date).month() + 1).toString() if dateFragment == 'months'
      date = "0#{date}" if date.length == 1

    selectedDate[dateFragment] = date
    window.location.href = "#/#{_.filter(selectedDate, (obj) ->
                                                          return obj != null
                                                        ).join('/')}"
