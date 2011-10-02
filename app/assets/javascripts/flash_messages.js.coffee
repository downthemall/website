#= require growl
$ =>
  @growl_notice = (text) ->
    return unless text.length
    $.jGrowl text, { header: "Notice", position: 'bottom-right', life: 1500 }

  @growl_alert = (text) ->
    return unless text.length
    $.jGrowl text, { header: "Alert", sticky: yes, position: 'bottom-right' }

  $(".notice.flash-message").hide().each -> growl_notice($(@).html())
  $(".alert.flash-message").hide().each -> growl_alert($(@).html())
