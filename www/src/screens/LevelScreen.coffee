# Valley of Bones
# (c) 2013 Jami Couch
# Apache 2.0 License
# ahsgaming.com

class LevelScreen extends valleyofbones.Screen
  constructor: (@game) ->
    super(@game)

    @map = new valleyofbones.MapView(@game)

    @map.on 'mousedown', (evt) ->
      @offset =
        x: @x - evt.stageX
        y: @y - evt.stageY

    @map.on 'pressmove', (evt) ->
      @x = evt.stageX + @offset.x
      @y = evt.stageY + @offset.y

    @turn_panel = new valleyofbones.TurnPanel(@game)

    @ui_layer = new createjs.Container()
    @ui_layer.addChild(@turn_panel)

  show: ->
    super()

    @addChild(@map)
    @addChild(@ui_layer)

    $('#ui').addClass('hidden') # JC: This is important to allow mouse events to reach the canvas

    @game.start_game()

  layout: ->
    {width: @ui_layer.width, height: @ui_layer.height} = @

  resize: (@width, @height) ->
    super(@width, @height)

    @layout()

  update: (delta) ->
    @map?.update?(delta)
    @turn_panel.update(delta)

valleyofbones.LevelScreen = LevelScreen
