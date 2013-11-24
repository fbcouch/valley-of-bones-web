# Valley of Bones
# (c) 2013 Jami Couch
# Apache 2.0 License
# ahsgaming.com


# This is the class that handles the rules and moving units around, etc
# Make sure this is decoupled from the view!!
class Game
  constructor: (@map_name, @players) ->
    createjs.EventDispatcher.initialize(@)

    # TODO load maps from json docs
    map_def =
      tiles: ((1 for j in [0...20]) for i in [0...9])

    @map = new valleyofbones.Map(map_def)

    @units = []

    @current_player = 0

  start_game: () ->
    for player, i in @players
      unit = new valleyofbones.Unit(preload.getResult('units').entities[0], player)
      @units.push unit
      unit.boardX = 1 + 17 * i
      unit.boardY = 4
    @dispatchEvent('units_changed')

    @start_turn(@current_player)

  end_game: () ->

  start_turn: (player) ->

  end_turn: (player_id) ->
    if @get_current_player().id is player_id
      @current_player = (@current_player + 1) % @players.length
      @start_turn(@current_player)

  can_do_command: () ->

  do_command: () ->

  attack: () ->

  can_build: (player_id, unit_id, boardX, boardY) ->
    true

  build: (player_id, unit_id, boardX, boardY) ->
    if @can_build(player_id, unit_id, boardX, boardY)
      unit = new valleyofbones.Unit(@get_unit_def_by_id(unit_id), @get_player_by_id(player_id))
      unit.boardX = boardX
      unit.boardY = boardY
      @units.push unit
      @dispatchEvent('units_changed')
      return true
    false

  move: () ->

  get_current_player: () ->
    @players[@current_player]

  get_player_by_id: (player_id) ->
    return player for player in @players when player.id is player_id
    null

  get_unit_def_by_id: (unit_id) ->
    return unit for unit in preload.getResult('units').entities when unit.id is unit_id

valleyofbones.Game = Game