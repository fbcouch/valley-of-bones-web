# Valley of Bones
# (c) 2013 Jami Couch
# Apache 2.0 License
# ahsgaming.com

class MapView extends createjs.Container
  constructor: (@game, @level_screen) ->
    @initialize()

    @tile_layer = new createjs.Container()
    @unit_layer = new createjs.Container()

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
          @tile_layer.addChild bitmap
          bitmap.x = c * bitmap.width + (if r % 2 is 1 then bitmap.width * 0.5 else 0)
          bitmap.y = r * bitmap.height * 0.75
          bitmap.boardX = c
          bitmap.boardY = r
          bitmap.on 'click', (event) =>
            @hex_clicked(event.currentTarget.boardX, event.currentTarget.boardY)

    @addChild(@tile_layer)
    @addChild(@unit_layer)

    @on 'mousedown', (evt) ->
      @dragged = false
      @offset =
        x: @x - evt.stageX
        y: @y - evt.stageY

    @on 'pressmove', (evt) ->
      @dragged = true
      @x = evt.stageX + @offset.x
      @y = evt.stageY + @offset.y

    @game.on 'units_changed', =>
      @rebuild_units()

    @rebuild_units()

    @update()

  update: (delta) ->

    for child in @children
      for c in child.children
        c.update?(delta)

    {width: @tile_layer.width, height: @tile_layer.height} = if @tile_layer.children.length > 0 then @tile_layer.getBounds() else {width: 0, height: 0}
    {width: @unit_layer.width, height: @unit_layer.height} = if @unit_layer.children.length > 0 then @unit_layer.getBounds() else {width: 0, height: 0}
    {width: @width, height: @height} = @getBounds() if @children.length > 0

  rebuild_units: ->
    @unit_layer.removeAllChildren()
    for unit in @units
      unit_view = new valleyofbones.UnitView(unit, @level_screen)
      unit_view.unit_id = unit.id
      @unit_layer.addChild(unit_view)
      unit_view.update()
      unit_view.on 'click', (event) =>
        @unit_clicked(event.currentTarget.unit_id)

  hex_clicked: (boardX, boardY) =>
    return if @dragged # dont fire this event if the map was dragged
#    console.log "(#{boardX}, #{boardY}) clicked"
    @level_screen.map_click_callback(boardX, boardY)

  unit_clicked: (unit_id) =>
    return if @dragged
    @level_screen.unit_click_callback(unit_id)

valleyofbones.MapView = MapView