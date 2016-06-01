'use strict'

eventsManager = new EventsManager
utils = new Utils

transitions = new Transitions(eventsManager)
map = new Map

axisProperties = { width: 3000, height: 30, x0: 50 }
axis = new Axis(eventsManager, axisProperties)

timelineProperties = { width: 3000, height: utils.timelineHeight, x0: 50 }
timeline = new Timeline(axis, timelineProperties, eventsManager)

eventsManager.addListener(map)
eventsManager.addListener(axis)
eventsManager.addListener(transitions)
eventsManager.addListener(timeline)

eventsManager.getData( ->
  eventsManager.shouldRender()
)
