'use strict'

eventsManager = new EventsManager
utils = new Utils
map = new Map

eventsManager.getData( ->
  map.render( ->
              axisProperties = { width: 3000, height: 30, x0: 50 }
              axis = new Axis(eventsManager, axisProperties)
              eventsManager.addListener(axis)
              eventsManager.addListener(map)
              axis.render())
              # timeline = new Timeline
              # timeline.addListener(map)
              # timeline.render())
)
