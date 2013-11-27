# Valley of Bones
# (c) 2013 Jami Couch
# Apache 2.0 License
# ahsgaming.com

class ImageButton extends valleyofbones.UIElement
  constructor: (@image, style) ->
    style or=
      background: '#CCCCCC'
      'border-radius': '10px'
      padding:
        top: 5
        bottom: 5
        left: 5
        right: 5
      alpha: 0.7
    super(style)

  layout: () ->
#    console.log @style
    super()


  update_layout: () ->
    super()
#    console.log @style
    @fg_image = asset_mgr.get_bitmap(@image)

    @width = @fg_image.width + parseFloat(@style.padding?.left or 0) + parseFloat(@style.padding?.right or 0) if not @width?
    @height = @fg_image.height + parseFloat(@style.padding?.top or 0) + parseFloat(@style.padding?.bottom or 0) if not @height?

    @create_background()

    @addChild @fg_image

    @fg_image.x = (@width - @fg_image.width) * 0.5
    @fg_image.y = (@height - @fg_image.height) * 0.5

  ui_cache: ->
    super()
    @_cached.image = @image

valleyofbones.ImageButton = ImageButton