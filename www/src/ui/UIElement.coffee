# Valley of Bones
# (c) 2013 Jami Couch
# Apache 2.0 License
# ahsgaming.com

class UIElement extends createjs.Container
  constructor: (@style) ->
    @initialize()

    @style or= {}

    @layout()

  layout: () ->
    @parent_w = (@parent?.width or @parent?.getBounds()?.width or 0)
    @parent_h = (@parent?.width or @parent?.getBounds()?.height or 0)
    if @_cached? and not @diff(@_cached, @)
      @ui_cache()
      return

    @removeAllChildren()

    if (@style.width?)
      @width = @parse_attr(@style.width, @parent_w)
    if (@style.height?)
      @height = @parse_attr(@style.height, @parent_h)

    @alpha = (@style.alpha or 1)

    @update_layout()

    @ui_cache()

  update_layout: () ->

  create_background: () ->
    @bg_shape = new createjs.Shape()

    @bg_shape.graphics.beginFill(@style.background).drawRoundRect(0, 0, @width, @height, (@parse_attr(@style['border-radius'], Math.min(@width, @height)) or 0)) if @style.background?
    @bg_shape.setBounds(0, 0, @width, @height)
    @addChild @bg_shape

  parse_attr: (attr, mul) ->
    return 0 if not attr?
    if attr.indexOf('%') isnt -1
      pct = parseFloat(attr.split('%')[0]) / 100
      return mul * pct
    else
      return parseFloat(attr)

  ui_cache: ->
    @_cached =
      style: JSON.parse(JSON.stringify(@style))
      parent_w: @parent_w
      parent_h: @parent_h

  diff: (a, b) ->
    for key of a
      if typeof a[key] is 'object'
        return true if @diff(a[key], b[key])
      else if a[key] isnt b[key]
        return true
    false

  set_style: (style) =>
    @style[key] = val for key, val of style
    console.log @style

valleyofbones.UIElement = UIElement