# Valley of Bones
# (c) 2013 Jami Couch
# Apache 2.0 License
# ahsgaming.com


# This is the class that handles the rules and moving units around, etc
# Make sure this is decoupled from the view!!
class Game
  constructor: (@map_name, @players) ->
    # TODO load maps from json docs
    map_def =
      tiles: ((1 for j in [0...20]) for i in [0...10])

    @map = new valleyofbones.Map(map_def)

    @units = []

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