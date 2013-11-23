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

    @units.push new valleyofbones.Unit(preload.getResult('units').entities[0], null)
    @units[0].boardX = 1

  start_game: () ->

  end_game: () ->

  start_turn: () ->

  end_turn: () ->

  can_do_command: () ->

  do_command: () ->

  attack: () ->

  build: () ->

  move: () ->

valleyofbones.Game = Game