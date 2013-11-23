# Valley of Bones
# (c) 2013 Jami Couch
# Apache 2.0 License
# ahsgaming.com

class Button extends createjs.Container
  constructor: (@text, @style) ->
    @initialize()

    @style or= {}

    @layout()

  layout: () ->
    if @_cached? and not @diff(@_cached, @)
      @ui_cache()
      return

    @removeAllChildren()
    @parent_w = (@parent?.width or @parent?.getBounds()?.width or 0)
    @parent_h = (@parent?.width or @parent?.getBounds()?.height or 0)

    if (@style.width?)
      @width = @parse_attr(@style.width, @parent_w)
    if (@style.height?)
      @height = @parse_attr(@style.height, @parent_h)

    @text_element = new createjs.Text(@text, (@style.font or 'normal 20px Courier'), (@style.color or '#000000'))
    @width = @text_element.getBounds().width if not @width?
    @height = @text_element.getBounds().height + parseFloat(@style.padding?.top or 0) + parseFloat(@style.padding?.bottom or 0) if not @height?
    @bg_shape = new createjs.Shape()
    @bg_shape.graphics.beginFill((@style.background or '#CCCCCC')).drawRoundRect(0, 0, @width, @height, (@parse_attr(@style['border-radius'], Math.min(@width, @height)) or 0))

    @addChild @bg_shape
    @addChild @text_element

    switch @style['text-align']
      when 'left'
        @text_element.x = 0
      when 'center'
        @text_element.x = (@width - @text_element.getBounds()?.width) * 0.5
      when 'right'
        @text_element.x = @width - @text_element.getBounds()?.width
      else
        @text_element.x = 0

    @text_element.y = parseFloat(@style.padding?.top or 0) + (@height - parseFloat(@style.padding?.bottom or 0) - @text_element.getBounds()?.height) * 0.5

    @alpha = (@style.alpha or 1)


    @ui_cache()

  parse_attr: (attr, mul) ->
    if attr.indexOf('%') isnt -1
      pct = parseFloat(attr.split('%')[0]) / 100
      return mul * pct
    else
      return parseFloat(attr)

  ui_cache: ->
    @_cached =
      text: @text
      style: JSON.parse(JSON.stringify(@style))
      parent_w: (@parent?.width or @parent?.getBounds()?.width or 0)
      parent_h: (@parent?.width or @parent?.getBounds()?.height or 0)

  diff: (a, b) ->
    for key of a
      if typeof a[key] is 'object'
        return true if @diff(a[key], b[key])
      else if a[key] isnt b[key]
        return true
    false


valleyofbones.Button = Button