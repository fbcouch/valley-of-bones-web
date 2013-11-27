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
#    @setMainMenuScreen()
    @setLevelScreen()

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
    @game?.update?(delta)

  setSplashScreen: () ->
    console.log 'setSplashScreen'
    @setScreen(new valleyofbones.SplashScreen(@))

  setMainMenuScreen: () ->
    console.log 'setMainMenuScreen'
    @setScreen(new valleyofbones.MainMenuScreen(@))

  setLevelScreen: () ->
    console.log 'setLevelScreen'

    players = [new valleyofbones.Player(generate_id(), 'Player 1', [1, 0, 0]), new valleyofbones.AIPlayer(generate_id(), 'Player 2', [0, 0, 1])]
    @game = new valleyofbones.Game('test_level', players)
    @setScreen(new valleyofbones.LevelScreen(@game, players[0]))

valleyofbones.VOB = VOB