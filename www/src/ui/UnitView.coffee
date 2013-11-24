# Valley of Bones
# (c) 2013 Jami Couch
# Apache 2.0 License
# ahsgaming.com

class UnitView extends createjs.Container
  constructor: (@unit, @level_screen) ->
    @initialize()

    @base_image = asset_mgr.get_bitmap(@unit.unit_def.image)
    @overlay_image = asset_mgr.get_bitmap("#{@unit.unit_def.image}-overlay")

    @overlay_image.filters = [new createjs.ColorFilter(@unit.owner.color[0], @unit.owner.color[1], @unit.owner.color[2], 1)]
    @overlay_image.cache(0, 0, @overlay_image.width, @overlay_image.height);

    @select_image = new createjs.Shape()
    @select_image.graphics.beginStroke("rgba(#{@unit.owner.color[0] * 255}, #{@unit.owner.color[1] * 255}, #{@unit.owner.color[2] * 255}, 1)").drawCircle(32, 32, 32)


    @addChild @base_image
    @addChild @overlay_image

  update: (delta) ->
    if @level_screen.selected is @unit.id
      @addChildAt(@select_image, 0) if not @select_image.parent
    else
      @removeChild(@select_image) if @select_image.parent

    @x = @unit.boardX * 64 + (if @unit.boardY % 2 is 1 then 32 else 0)
    @y = @unit.boardY * 48

valleyofbones.UnitView = UnitView