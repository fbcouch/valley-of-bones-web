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

  layout: ->
    {width: @ui_layer.width, height: @ui_layer.height} = @

  resize: (@width, @height) ->
    super(@width, @height)

    @layout()

  update: (delta) ->
    @map?.update?(delta)
    @turn_panel.update(delta)

valleyofbones.LevelScreen = LevelScreen


class MapView extends createjs.Container
  constructor: (@game) ->
    @initialize()

    @map = @game.map
    @units = @game.units
    @tiles = []
    for row, r in @map.tiles
      @tiles.push([])
      for col, c in row when col?
        if col.tile is 0
          @tiles[r].push(null)
        else
          bitmap = asset_mgr.get_bitmap('dirt-hex')
          @tiles[r].push(bitmap)
          @addChild bitmap
          bitmap.x = c * bitmap.width + (if r % 2 is 1 then bitmap.width * 0.5 else 0)
          bitmap.y = r * bitmap.height * 0.75
    {width: @width, height: @height} = @getBounds() if @children.length > 0

  update: (delta) ->

valleyofbones.MapView = MapView


class Panel extends createjs.Container
  constructor: () ->
    @initialize()

  update: (delta) ->
    child.update?(delta) for child in @children

    {width: @width, height: @height} = if @children.length > 0 then @getBounds() else {width: 0, height: 0}

valleyofbones.Panel = Panel

class TurnPanel extends valleyofbones.Panel
  constructor: (@game) ->
    super()

    @timer_text = new createjs.Text '', 'normal 40px courier', '#CCC'
    @addChild @timer_text

    @btn_end_turn = new createjs.Text 'END TURN', 'normal 40px courier', '#CCC'
    @addChild @btn_end_turn

  update: (delta) ->
    @timer_text.text = "TIME LEFT 00:00"

    @btn_end_turn.y = @timer_text.y + @timer_text.getBounds().height + 30

    super(delta)

valleyofbones.TurnPanel = TurnPanel

