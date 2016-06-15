'use strict'

eventsManager = new EventsManager
utils = new Utils

transitions = new Transitions(eventsManager)
map = new Map

yearsProperties = { width: 3000, height: 50, x0: 50, y0: 0, axisClass: 'years' }
years = new Years(eventsManager, yearsProperties)
monthsProperties2 = { width: 3000, height: 50, x0: 50, y0: 0, axisClass: 'months' }
months = new Months(eventsManager, monthsProperties2)
daysProperties3 = { width: 3000, height: 50, x0: 50, y0: 0, axisClass: 'days' }
days = new Days(eventsManager, daysProperties3)

timelineProperties = { width: 3000, height: utils.timelineHeight, x0: 60 }
timeline = new Timeline(years, timelineProperties, eventsManager)

eventsManager.addListener(map)
eventsManager.addListener(years)
eventsManager.addListener(months)
eventsManager.addListener(days)
eventsManager.addListener(transitions)
eventsManager.addListener(timeline)

eventsManager.getData( ->
  eventsManager.shouldRender()
)
