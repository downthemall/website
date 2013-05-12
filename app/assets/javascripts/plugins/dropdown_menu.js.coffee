class @DropdownMenu extends Plugin
  load: ->
    @$menu = @domFromData('menu-dom')
    @$dom.click =>
      @$menu.toggleClass('visible')
      false

