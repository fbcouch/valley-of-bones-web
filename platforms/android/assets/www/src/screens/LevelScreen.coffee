# Valley of Bones
# (c) 2013 Jami Couch
# Apache 2.0 License
# ahsgaming.com

class LevelScreen extends valleyofbones.Screen
  constructor: (@game, @player) ->
    super(@game)

    @bg_image = new createjs.Shape()
    @addChild @bg_image

    @bg_image.on 'click', =>
      @selected = null
      @build_mode = null

    @map = new valleyofbones.MapView(@game, @)

    @turn_panel = new valleyofbones.TurnPanel(@game, @)

    @ui_layer = new createjs.Container()
    @ui_layer.addChild(@turn_panel)

    @build_panel = new valleyofbones.BuildPanel(@game, @)
    @ui_layer.addChild(@build_panel)

    @selected = null
    @build_mode = null

  show: ->
    super()

    @addChild(@map)
    @addChild(@ui_layer)

    $('#ui').addClass('hidden') # JC: This is important to allow mouse events to reach the canvas

    @game.start_game()

  layout: ->
    {width: @ui_layer.width, height: @ui_layer.height} = @

    if not @first_done
      @map.x = (@width - @map.width) * 0.5
      @map.y = (@height - @map.height) * 0.5
      @first_done = true

  resize: (@width, @height) ->
    super(@width, @height)

    @bg_image.graphics.clear().beginFill('#111111').drawRect(0, 0, @width, @height)

    @layout()

  update: (delta) ->
    @map?.update?(delta)
    @turn_panel.update(delta)
    @build_panel.update(delta)

    @build_panel.x = 0
    @build_panel.y = @height - @build_panel.height

  set_selected: (unit) ->

  get_selected: () ->

  set_build_mode: (unit_id) ->
    return if not unit_id or @player isnt @game.get_current_player()
    console.log "build mode: #{unit_id}"
    @build_mode = unit_id
    @selected = null

  build: (unit_id, boardX, boardY) ->
    console.log "Build #{unit_id} at (#{boardX}, #{boardY})"
    if @game.build(@player.id, unit_id, boardX, boardY)
      @build_mode = null

  move: (unit_id, boardX, boardY) ->
    console.log "Move #{unit_id} to (#{boardX}, #{boardY})"
    @game.move(@player.id, unit_id, boardX, boardY)

  attack: (attacker, defender) ->
    console.log "Attack #{attacker} to #{defender}"
    @game.attack(@player.id, attacker, defender)

  map_click_callback: (boardX, boardY) ->
    if @build_mode?
      @build(@build_mode, boardX, boardY)
    else if @selected?
      @move(@selected, boardX, boardY)

  unit_click_callback: (unit_id) ->
    @build_mode = null
    if not @selected
      @selected = unit_id
    else
      if @game.get_unit_by_id(@selected).owner is @player
        if @game.get_unit_by_id(unit_id).owner is @player
          @selected = unit_id
        else
          @attack(@selected, unit_id)
      else
        @selected = unit_id

  end_turn: ->
    if @player is @game.get_current_player()
      console.log "Player #{@player.id} end turn"
      @game.end_turn(@player.id)


valleyofbones.LevelScreen = LevelScreen
