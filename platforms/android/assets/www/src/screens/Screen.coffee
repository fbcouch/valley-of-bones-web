# Valley of Bones
# (c) 2013 Jami Couch
# Apache 2.0 License
# ahsgaming.com

class Screen extends createjs.Container
  constructor: (@game) ->
    @initialize()
    $('#ui').html('')

  update: (delta) ->

  show: () ->

  resize: (@width, @height) ->

  hide: () ->

valleyofbones.Screen = Screen

