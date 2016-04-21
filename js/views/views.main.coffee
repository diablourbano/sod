'use strict'

map = new Map

map.render( ->
            timeline = new Timeline
            timeline.addListener(map)
            timeline.render())
