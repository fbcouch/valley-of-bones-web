# Valley of Bones
# (c) 2013 Jami Couch
# Apache 2.0 License
# ahsgaming.com

class AIPlayer extends valleyofbones.Player

  update: (delta, game) ->
    if (game.get_current_player() is @)
      game.end_turn(@id)

valleyofbones.AIPlayer = AIPlayer