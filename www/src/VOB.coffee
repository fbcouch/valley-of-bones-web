# Valley of Bones
# (c) 2013 Jami Couch
# Apache 2.0 License
# ahsgaming.com

class VOB
  constructor: (@stage) ->
    @screen = null

  resize: (@width, @height) ->
    @screen?.resize(@width, @height)

  start: () ->
#    @setSplashScreen()
    @setMainMenuScreen()

  setScreen: (screen) ->
    if @screen?
      @stage.removeChild @screen
      @screen.hide()
    @screen = screen
    @stage.addChild @screen
    @screen.show()
    @screen.resize(@width, @height)

  update: (delta) ->
    @screen?.update(delta)

  setSplashScreen: () ->
    console.log 'setSplashScreen'
    @setScreen(new valleyofbones.SplashScreen(@))

  setMainMenuScreen: () ->
    console.log 'setMainMenuScreen'
    @setScreen(new valleyofbones.MainMenuScreen(@))

  setLevelScreen: () ->
    console.log 'setLevelScreen'
    @setScreen(new valleyofbones.LevelScreen(@, 'test_level', []))

valleyofbones.VOB = VOB