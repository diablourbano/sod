'use strict'

class LocaleUI
  eventsManager = null

  setUIToLocale = (localeToUse) ->
    moment.locale(localeToUse)

  constructor: (defaultLocale, evntMngr) ->
    eventsManager = evntMngr

    setUIToLocale(defaultLocale)

  $('.lang').on('click', (e) ->
    previousLocale = moment.locale()
    setUIToLocale(e.target.text)

    $('.language .selected .lang-to-use').text(moment.locale())
    $(this).text(previousLocale)
    $('.language .lang-options').toggleClass('visible')

    eventsManager.shouldTranslate(previousLocale)
  )

  $('.language .selected').on('click', ->
    $('.language .lang-options').toggleClass('visible')
  )
