# Valley of Bones
# (c) 2013 Jami Couch
# Apache 2.0 License
# ahsgaming.com

class Panel extends createjs.Container
  constructor: () ->
    @initialize()

  update: (delta) ->
    child.update?(delta) for child in @children

    {width: @width, height: @height} = if @children.length > 0 then @getBounds() else {width: 0, height: 0}

valleyofbones.Panel = Panel
