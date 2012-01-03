$ = jQuery

switch_template = '
  <div class="ui-switch">
    <div class="ui-switch-inner">
      <div class="ui-switch-mask">
        <span class="ui-switch-on">{{on}}</span>
        <span class="ui-switch-handle"></span>
        <span class="ui-switch-off">{{off}}</span>
      </div>
    </div>
  </div>
'

build_switch = ($select, options = {}) ->

  # hide select and disable select gain focus
  $select.hide()
  $select.attr('tabindex', '-1')

  # get the initial val, and determine if it is disabled
  $options = $select.find('option')
  value = $select.val()
  disabled = !!$select.attr('disabled')

  # get the on/off values and labels
  values =
    on: options.on or $options.first().val()
    off: options.off or $options.last().val()

  labels =
    on: $options.first().text()
    off: $options.last().text()

  select_state = -> if $select.val() == values.on then 'on' else 'off'
  select_inverted_state = -> if select_state() == 'on' then 'off' else 'on'

  # build switch
  $switch = $(switch_template.replace('{{on}}', labels.on).replace('{{off}}', labels.off))
  $switch.addClass(select_state())

  # if the <select> is disabled, add class 'disabled'
  $switch.addClass('disabled') if disabled

  # append to DOM
  $switch.insertAfter($select)

  # references
  $select.data('switch', $switch)
  $switch.data('select', $select)

  # switch controls
  controls =
    on:     -> $switch.trigger('slide:on') unless disabled
    off:    -> $switch.trigger('slide:off') unless disabled
    toggle: -> $switch.trigger("slide:#{select_inverted_state()}") unless disabled

  $switch.data('controls', controls)

  # switch events
  $switch.attr('tabindex', '0')
  $switch.keyup (e) -> controls.toggle() if e.which == 13
  $switch.click -> controls.toggle()

  # cache inner elements
  $mask = $(".ui-switch-mask", $switch)

  # left position for both states
  left_on = 0
  left_off = - $(".ui-switch-on", $switch).width()

  $switch.bind('slide:on', ->
    $switch.data('animating', true)
    $mask.stop().animate(left: left_on, 'fast', ->
      $switch.data('animating', false).data('select').val(values.on).change()
      $switch.removeClass('off').addClass('on')
    )
  )

  $switch.bind('slide:off', ->
    $switch.data('animating', true)
    $mask.stop().animate(left: left_off, 'fast', ->
      $switch.data('animating', false).data('select').val(values.off).change()
      $switch.removeClass('on').addClass('off')
    )
  )

$.fn.switch = (options = {}) ->
  @each (i, select) ->
    $select = $(select)
    build_switch($select, options) unless $select.data('switch')
  this

