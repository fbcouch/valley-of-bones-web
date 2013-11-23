# Valley of Bones
# (c) 2013 Jami Couch
# Apache 2.0 License
# ahsgaming.com

window.valleyofbones = {}

# auto loader
sources = [
  "screen"
]

manifest = [
  {id: 'units', src: 'assets/units.json'}
  {id: 'assets-img', src: 'assets/assets.png'}
  {id: 'assets-json', src: 'assets/assets.json'}
]

#$('body').append("<script src=\"out/#{file}.js\"></script>") for file in sources

window.generate_id = ->
  _keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="
  (
    (
      for i in [0...16]
        _keyStr.charAt(Math.random() * _keyStr.length)
    )
  ).join('')

$(document).on 'ready', ->
  console.log 'ready'
  window.preload = new createjs.LoadQueue()

  window.canvas = $('#gameCanvas')[0]
  window.stage = new createjs.Stage canvas
#  createjs.Touch.enable(stage)
  window.game = new valleyofbones.VOB(stage)

  canvas.width = document.documentElement.clientWidth
  canvas.height = document.documentElement.clientHeight

  game.resize(canvas.width, canvas.height)

  window.onresize = () ->
    canvas.width = document.documentElement.clientWidth
    canvas.height = document.documentElement.clientHeight
    stage.update()
    game.resize(canvas.width, canvas.height)

  preload.loadManifest manifest
  preload.addEventListener 'complete', =>
    # do something
    window.asset_mgr = new valleyofbones.AssetManager(preload.getResult('assets-img'), preload.getResult('assets-json'))

    game.start()

    createjs.Ticker.addEventListener 'tick', (event) ->
      stage.update(event)
      game.update(event.delta / 1000) if event.delta



  preload.addEventListener 'progress', (progress) =>
    $('#ui .progress-bar').css({'width': "#{progress.loaded * 100|0}%"})
    $('#ui .progress span').html("Loading #{progress.loaded * 100|0}%")





