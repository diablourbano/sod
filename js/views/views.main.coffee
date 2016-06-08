'use strict'

eventsManager = new EventsManager
utils = new Utils

transitions = new Transitions(eventsManager)
map = new Map

axisProperties = { width: 3000, height: 30, x0: 50, y0: 0, axisClass: 'years' }
axis = new Years(eventsManager, axisProperties)
axisProperties2 = { width: 3000, height: 30, x0: 50, y0: 0, axisClass: 'months' }
axis2 = new Months(eventsManager, axisProperties2)
axisProperties3 = { width: 3000, height: 30, x0: 50, y0: 0, axisClass: 'days' }
axis3 = new Days(eventsManager, axisProperties3)

timelineProperties = { width: 3000, height: utils.timelineHeight, x0: 50 }
timeline = new Timeline(axis, timelineProperties, eventsManager)

# eventsManager.addListener(map)
eventsManager.addListener(axis)
eventsManager.addListener(axis2)
eventsManager.addListener(axis3)
eventsManager.addListener(transitions)
# eventsManager.addListener(timeline)

eventsManager.getData( ->
  eventsManager.shouldRender()
)
