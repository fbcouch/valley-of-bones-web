# Valley of Bones
# (c) 2013 Jami Couch
# Apache 2.0 License
# ahsgaming.com

class Button extends valleyofbones.UIElement
  constructor: (@text, @style) ->
    super(@style)

  update_layout: () ->
    super()

    @text_element = new createjs.Text(@text, (@style.font or 'normal 20px Courier'), (@style.color or '#000000'))
    @width = @text_element.getBounds().width if not @width?
    @height = @text_element.getBounds().height + parseFloat(@style.padding?.top or 0) + parseFloat(@style.padding?.bottom or 0) if not @height?

    @create_background()

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



  ui_cache: ->
    super()
    @_cached.text = @text

valleyofbones.Button = Button