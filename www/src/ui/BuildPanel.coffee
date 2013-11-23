# Valley of Bones
# (c) 2013 Jami Couch
# Apache 2.0 License
# ahsgaming.com

class BuildPanel extends valleyofbones.Panel
  constructor: (@game) ->
    super()
    @unit_buttons = {}
    @unit_container = new createjs.Container()



    @addChild @unit_container


  clicked: (event) =>
    console.log event.currentTarget.unit_id

  update: (delta) ->
    x = 0
    y = 0
    for unit, u in (unit for unit in preload.getResult('units').entities when unit.type is 'unit')
      if not @unit_buttons[unit.id]?
        btn = asset_mgr.get_bitmap(unit.image)
        @unit_buttons[unit.id] = btn
        btn.unit_id = unit.id
        btn.on 'click', @clicked
        @unit_container.addChild btn
      else
        btn = @unit_buttons[unit.id]

      if u % 3 is 0 and u > 0
        x = 0
        y = y + btn.height + 5
      btn.x = x
      btn.y = y
      x += btn.width + 5
      @filter(btn)

    super(delta)

  filter: (btn) ->
    btn.filters = [new createjs.ColorFilter(1, 0.5, 0.5, 1)]
    btn.cache(0, 0, btn.width, btn.height)

valleyofbones.BuildPanel = BuildPanel
