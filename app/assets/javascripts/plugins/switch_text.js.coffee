class @SwitchText extends Plugin
  load: ->
    @$toListen = @domFromData('to-listen-dom')
    @text = @fromData('toggle-text')
    @$toListen.change =>
      @update()
      false
    @update()

  update: ->
    val = @$toListen.val()
    @$dom.text @text[val]

