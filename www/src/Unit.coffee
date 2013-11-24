# Valley of Bones
# (c) 2013 Jami Couch
# Apache 2.0 License
# ahsgaming.com

class Unit
  constructor: (@unit_def, @owner, @id) ->
    @id or= generate_id()
    @boardX = 0
    @boardY = 0



valleyofbones.Unit = Unit