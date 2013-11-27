# Valley of Bones
# (c) 2013 Jami Couch
# Apache 2.0 License
# ahsgaming.com

class MainMenuScreen extends valleyofbones.Screen
  show: () ->
    super()

    $.ajax('main_menu.html').done (data) =>
      $('#ui').html(data)
      @bind_ui()

  bind_ui: ->
    $('#btn_sp').click @sp_click
    $('#btn_mp').click @mp_click
    $('#btn_opt').click @opt_click

  sp_click: =>
    @game.setLevelScreen()

  mp_click: =>

  opt_click: =>


valleyofbones.MainMenuScreen = MainMenuScreen