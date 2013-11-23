# Valley of Bones
# (c) 2013 Jami Couch
# Apache 2.0 License
# ahsgaming.com

class TurnPanel extends valleyofbones.Panel
  constructor: (@game) ->
    super()

    @timer_text = new createjs.Text '', 'normal 40px courier', '#CCC'
    @addChild @timer_text

    @btn_end_turn = new createjs.Text 'END TURN', 'normal 40px courier', '#CCC'
    @addChild @btn_end_turn

  update: (delta) ->
    @timer_text.text = "TIME LEFT 00:00"

    @btn_end_turn.y = @timer_text.y + @timer_text.getBounds().height + 30

    super(delta)

valleyofbones.TurnPanel = TurnPanel