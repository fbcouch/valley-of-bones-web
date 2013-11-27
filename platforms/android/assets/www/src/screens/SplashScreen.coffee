# Valley of Bones
# (c) 2013 Jami Couch
# Apache 2.0 License
# ahsgaming.com

class SplashScreen extends valleyofbones.Screen

  show: () ->
    super()

    @splash_img = asset_mgr.get_bitmap('splash')
    @splash_img.regX = @splash_img.sourceRect.width * 0.5
    @splash_img.regY = @splash_img.sourceRect.height * 0.5
    @splash_img.alpha = 0
    @addChild @splash_img

  resize: (@width, @height) ->
    super(@width, @height)

    @splash_img.x = @width * 0.5
    @splash_img.y = @height * 0.5

  update: (delta) ->
    super(delta)
    if not @up_finished
      @splash_img.alpha += delta * 0.5
      if @splash_img.alpha >= 1
        @splash_img.alpha = 1
        @up_finished = true
    else if @splash_img.alpha > 0
      @splash_img.alpha -= delta * 0.5
    else
      @game.setMainMenuScreen()

valleyofbones.SplashScreen = SplashScreen