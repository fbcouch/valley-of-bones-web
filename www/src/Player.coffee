# Valley of Bones
# (c) 2013 Jami Couch
# Apache 2.0 License
# ahsgaming.com

class Player
  constructor: (@id, @name, @color) ->
    @money = 0
    @income = 0
    @max_supply = 0
    @units = []

valleyofbones.Player = Player