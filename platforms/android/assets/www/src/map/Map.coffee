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


  #     (1, 1)     (2, 1)           (1, 0)      (2, 0)
  #          \     /                     \      /
  # (1, 2) -- (2, 2) -- (3, 2)  (0, 1) -- (1, 1) -- (2, 1)
  #          /     \                     /      \
  #     (1, 3)     (2, 3)           (1, 2)      (2, 2)

  get_map_dist: (x1, y1, x2, y2) ->
    # completion cases
    return Math.abs(y1 - y2) if x1 is x2
    return Math.abs(x1 - x2) if y1 is y2

    # move along gradient
    dx = x2 - x1
    dy = y2 - y1

    if (y1 % 2 is 0 and dx < 0)
      x1--
    else if (y1 % 2 == 1 and dx > 0)
      x1++

    if dy > 0
      y1++
    else
      y1--

    1 + @get_map_dist(x1, y1, x2, y2)

valleyofbones.Map = Map

class MapHex
  constructor: (@tile, @traversible) ->

valleyofbones.MapHex = MapHex