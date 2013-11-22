# Valley of Bones
# (c) 2013 Jami Couch
# Apache 2.0 License
# ahsgaming.com

class Map
  constructor: (@map_def) ->
    @tiles = []
    for row, r in @map_def.tiles
      @tiles.push([])
      for col, c in row
        switch col
          when 0 then @tiles[r].push(new valleyofbones.MapHex(col, false))
          when 1 then @tiles[r].push(new valleyofbones.MapHex(col, true))

valleyofbones.Map = Map

class MapHex
  constructor: (@tile, @traversible) ->

valleyofbones.MapHex = MapHex