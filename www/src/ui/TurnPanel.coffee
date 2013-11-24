# Valley of Bones
# (c) 2013 Jami Couch
# Apache 2.0 License
# ahsgaming.com

class TurnPanel extends valleyofbones.Panel
  constructor: (@game, @level_screen) ->
    super()

#    @timer_text = new createjs.Text '', 'normal 40px courier', '#CCC'
#    @addChild @timer_text

    btn_style =
      width: '100%'
      height: '80px'
      background: '#CCC'
      'border-radius': '10px'
      font: 'normal 40px courier'
      'text-align': 'center'
      color: '#000'
      padding:
        bottom: '5px'
      alpha: 0.8

    @btn_end_turn = new valleyofbones.Button('END TURN', btn_style)
    @addChild @btn_end_turn
    @btn_end_turn.on 'click', =>
      @level_screen.end_turn()

    @player_texts = {}

    @turn_indicator = asset_mgr.get_bitmap('reticule')
    @addChild(@turn_indicator)

  update: (delta) ->
    @btn_end_turn.style.background = if (@game.get_current_player() is @level_screen.player) then '#ccc' else '#333'

    @btn_end_turn.layout()
    y = 0
    x = @turn_indicator.width + 5
    for player in @game.players
      if not @player_texts[player.id]
        text = new createjs.Text player.name.toUpperCase(), 'normal 40px courier', "##{if player.color[0] then 'F' else '0'}#{if player.color[1] then 'F' else '0'}#{if player.color[2] then 'F' else '0'}"
        @player_texts[player.id] = text
        @addChild text
      else
        text = @player_texts[player.id]
      text.x = x
      text.y = y
      y += text.getBounds()?.height + 10
      if @game.get_current_player() is player
        @turn_indicator.x = 0
        @turn_indicator.y = text.y + (text.getBounds()?.height - @turn_indicator.height) * 0.5 + 5

    @btn_end_turn.y = y

    super(delta)

valleyofbones.TurnPanel = TurnPanel