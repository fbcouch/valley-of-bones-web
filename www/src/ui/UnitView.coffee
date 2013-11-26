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

    @move_icon = asset_mgr.get_bitmap('walking-boot')
    @move_icon.scaleX = 0.5
    @move_icon.scaleY = 0.5
    @attack_icon = asset_mgr.get_bitmap('rune-sword')
    @attack_icon.scaleX = 0.5
    @attack_icon.scaleY = 0.5

    @hp_bar = new createjs.Shape()

    @addChild @base_image
    @addChild @overlay_image
    @addChild @hp_bar

  update: (delta) ->
    if @level_screen.selected is @unit.id
      @addChildAt(@select_image, 0) if not @select_image.parent
    else
      @removeChild(@select_image) if @select_image.parent

    x = 0
    if @unit.status.moves_left > 0
      @addChild @move_icon if not @move_icon.parent?
      @move_icon.x = x
      @move_icon.y = 0
      x += @move_icon.width * @move_icon.scaleX
    else
      @removeChild @move_icon if @move_icon.parent?

    if @unit.status.attacks_left > 0
      @addChild @attack_icon if not @attack_icon.parent?
      @attack_icon.x = x
      @attack_icon.y = 0
      x += @attack_icon.width * @attack_icon.scaleX
    else
      @removeChild @attack_icon if @attack_icon.parent?

    if @cached_hp isnt @unit.status.curhp
      @cached_hp = @unit.status.curhp
      @hp_bar.width or= 0
      pct = @unit.status.curhp / @unit.status.maxhp
      color = '#00FF00'
      if pct < 0.5
        color = '#FFFF00'
      if pct < 0.25
        color = '#FF0000'
      @hp_bar.color = color
      createjs.Tween.get(@hp_bar).to({width: pct * @base_image.width}, 500)
    @hp_bar.graphics.clear().beginFill(@hp_bar.color).drawRect(0, 0, @hp_bar.width, 5);

    @hp_bar.x = 0
    @hp_bar.y = 48


    @x = @unit.boardX * 64 + (if @unit.boardY % 2 is 1 then 32 else 0)
    @y = @unit.boardY * 48

valleyofbones.UnitView = UnitView