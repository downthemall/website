$ ->
  $("[data-behaviour=autoresize]").each ->
    $textarea = $(this)
    mimics = [ "paddingTop", "paddingRight", "paddingBottom", "paddingLeft", "fontSize", "lineHeight", "fontFamily", "width", "fontWeight", "border-top-width", "border-right-width", "border-bottom-width", "border-left-width", "borderTopStyle", "borderTopColor", "borderRightStyle", "borderRightColor", "borderBottomStyle", "borderBottomColor", "borderLeftStyle", "borderLeftColor", "boxSizing", "-moz-box-sizing", "-webkit-box-sizing" ]
    $twin = $("<div/>").css
      'paddingBottom': '1.15em'
      'visibility': 'hidden'
    $container = $("<div/>").css(position: 'relative')

    i = mimics.length
    while i--
      $twin.css(mimics[i], $textarea.css(mimics[i]))

    $textarea.css
      height: '100%'
      overflow: 'hidden'
      position: 'absolute'
      width: '100%'

    $container.insertBefore($textarea)
    $container.append($textarea).append($twin)

    update = ->
      textareaContent = $textarea.val().replace(/&/g, "&amp;").replace(RegExp(" {2}", "g"), "&nbsp;").replace(/<|>/g, "&gt;").replace(/\n/g, "<br />")
      $twin.html textareaContent + "&nbsp;"

    $textarea.bind "keydown keyup change cut paste", update
    update()

