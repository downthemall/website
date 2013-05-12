class @Plugin
  constructor: (@dom) ->
    @$dom = $(@dom)
    unless @$dom.data('plugin-loaded')
      @$dom.data('plugin-loaded', true)
      @load()

  domFromData: (data) ->
    $ @fromData(data)

  fromData: (data) ->
    @$dom.data(data)

