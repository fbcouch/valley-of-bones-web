# Valley of Bones
# (c) 2013 Jami Couch
# Apache 2.0 License
# ahsgaming.com

class AssetManager
  constructor: (@image, @json) ->

  get: (key) ->
    @json.frames["#{key}.png"] or {}

  get_bitmap: (key) ->
    bitmap = new createjs.Bitmap @image
    defs = @get(key)
    bitmap.sourceRect =
      x:      defs.frame.x
      y:      defs.frame.y
      width:  defs.frame.w
      height: defs.frame.h
    bitmap.width = defs.frame.w
    bitmap.height = defs.frame.h
    bitmap

valleyofbones.AssetManager = AssetManager