'use strict'

class MainController

  urlManager = new UrlManager
  eventsManager = new EventsManager(urlManager)

  utils = new Utils

  transitions = new Transitions(eventsManager)
  map = new Map(eventsManager)

  yearsProperties = { width: 3000, height: 50, x0: 50, y0: 0, axisClass: 'years' }
  years = new Years(eventsManager, yearsProperties)
  monthsProperties = { width: 3000, height: 50, x0: 50, y0: 0, axisClass: 'months' }
  months = new Months(eventsManager, monthsProperties)
  daysProperties = { width: 3000, height: 50, x0: 50, y0: 0, axisClass: 'days' }
  days = new Days(eventsManager, daysProperties)

  timelineProperties = { width: 3000, height: utils.timelineHeight, x0: 60 }
  timeline = new Timeline(years, timelineProperties, eventsManager)

  constructor: ->
    eventsManager.addListener(map)
    eventsManager.addListener(years)
    eventsManager.addListener(months)
    eventsManager.addListener(days)
    eventsManager.addListener(transitions)
    eventsManager.addListener(timeline)

  draw: ->
    map.draw( ->
      eventsManager.shouldRender()
    )


mainController = new MainController
mainController.draw()
