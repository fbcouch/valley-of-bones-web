# Valley of Bones
# (c) 2013 Jami Couch
# Apache 2.0 License
# ahsgaming.com

class LevelScreen extends valleyofbones.Screen
  constructor: (@game, @map_name, @players) ->
    super(@game)

  show: ->
    super()

    $.ajax('level_ui.html').done (data) =>
      $('#ui').html(data)
      @bind_ui()

  bind_ui: ->



valleyofbones.LevelScreen = LevelScreen