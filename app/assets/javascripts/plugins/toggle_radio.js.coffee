class @ToggleRadio extends Plugin
  load: ->
    @$radio = @domFromData('toggle-radio-dom')
    name = @$radio.attr('name')
    @$radios = $("[name='#{name}']:radio")

    @$radios.change =>
      @update()

    @$dom.click =>
      @select()
      false

    @update()

  select: ->
    @$radio.prop('checked', true).change()

  update: ->
    selected = @$radios.filter(':checked').val() == @$radio.val()
    @$dom.toggleClass('selected', selected)

