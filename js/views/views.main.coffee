'use strict'

eventsManager = new EventsManager
utils = new Utils
map = new Map

eventsManager.getData( ->
  map.render( ->
              transitions = new Transitions(eventsManager)

              axisProperties = { width: 3000, height: 30, x0: 50 }
              axis = new Axis(eventsManager, axisProperties)

              eventsManager.addListener(axis)
              eventsManager.addListener(map)
              eventsManager.addListener(transitions)

              axis.render()

              timelineProperties = { width: 3000, height: utils.timelineHeight, x0: 50 }
              timeline = new Timeline(axis, timelineProperties, eventsManager)
              eventsManager.addListener(timeline)
              timeline.render())
)
