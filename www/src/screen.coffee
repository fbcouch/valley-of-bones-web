# Valley of Bones
# (c) 2013 Jami Couch
# Apache 2.0 License
# ahsgaming.com

class Screen extends createjs.Container
  constructor: (@game) ->
    @initialize()
    $('#ui').html('')

  update: (delta) ->

  show: () ->

  resize: (@width, @height) ->

  hide: () ->

valleyofbones.Screen = Screen

class SplashScreen extends valleyofbones.Screen

  show: () ->
    super()

    asset_mgr.get 'splash'
    splash_def = asset_mgr.get('splash')

    @splash_img = new createjs.Bitmap preload.getResult('assets-img')
    @splash_img.sourceRect =
      x: splash_def.frame.x
      y: splash_def.frame.y
      width: splash_def.frame.w
      height: splash_def.frame.h
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

class MainMenuScreen extends valleyofbones.Screen
  show: () ->
    super()

    $.ajax('main_menu.html').done (data) ->
      $('#ui').html(data)

valleyofbones.MainMenuScreen = MainMenuScreen