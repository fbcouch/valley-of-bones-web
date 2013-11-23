# Valley of Bones
# (c) 2013 Jami Couch
# Apache 2.0 License
# ahsgaming.com

class TurnPanel extends valleyofbones.Panel
  constructor: (@game) ->
    super()

    @timer_text = new createjs.Text '', 'normal 40px courier', '#CCC'
    @addChild @timer_text

    btn_style =
      width: '100%'
      height: '80px'
      background: '#333333'
      'border-radius': '10px'
      font: 'normal 40px courier'
      'text-align': 'center'
      color: '#CCC'
      padding:
        bottom: '5px'
      alpha: 0.8

    @btn_end_turn = new valleyofbones.Button('END TURN', btn_style)
    @addChild @btn_end_turn
    @btn_end_turn.on 'click', =>
      console.log 'clicked'

  update: (delta) ->
    @btn_end_turn.layout()
    @timer_text.text = "TIME LEFT 00:00"

    @btn_end_turn.y = @timer_text.y + @timer_text.getBounds().height + 30

    super(delta)

valleyofbones.TurnPanel = TurnPanel