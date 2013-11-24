# Valley of Bones
# (c) 2013 Jami Couch
# Apache 2.0 License
# ahsgaming.com

class BuildPanel extends valleyofbones.Panel
  constructor: (@game, @level_screen) ->
    super()
    @unit_buttons = {}
    @unit_container = new createjs.Container()

    @addChild @unit_container


  clicked: (event) =>
    console.log event.currentTarget.unit_id
    @level_screen.set_build_mode?(event.currentTarget.unit_id)

  update: (delta) ->
    x = 0
    y = 0
    for unit, u in (unit for unit in preload.getResult('units').entities when unit.type is 'unit')
      if not @unit_buttons[unit.id]?
        btn = new valleyofbones.ImageButton(unit.image)
        @unit_buttons[unit.id] = btn
        btn.unit_id = unit.id
        btn.on 'click', @clicked
        @unit_container.addChild btn
      else
        btn = @unit_buttons[unit.id]
      if @level_screen.build_mode is unit.id
#        btn.set_style({background: '#ffff00'})
        btn.style.background = '#cccc00'
      else
        btn.style.background = if (@game.get_current_player() isnt @level_screen.player) then '#cc6666' else '#cccccc'
      if u % 3 is 0 and u > 0
        x = 0
        y = y + btn.height + 5
      btn.x = x
      btn.y = y
      x += btn.width + 5
      btn.layout()
#      @filter(btn)

    super(delta)

  filter: (btn) ->
    btn.filters = [new createjs.ColorFilter(1, 0.5, 0.5, 1)]
    btn.cache(0, 0, btn.width, btn.height)

valleyofbones.BuildPanel = BuildPanel
