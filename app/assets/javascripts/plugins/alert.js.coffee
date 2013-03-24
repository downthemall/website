class @Alert extends Plugin
  load: ->
    $.meow(message: @$dom.html(), title: @fromData('title'))
