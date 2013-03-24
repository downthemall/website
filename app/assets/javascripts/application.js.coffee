#= require ./vendor/jquery
#= require_tree ./vendor
#= require plugin
#= require_tree ./plugins

$ ->
  $('[data-behaviour]').each ->
    new window[$(@).data('behaviour')](@)

  $("[href=#sign-in]").click ->
    navigator.id.request()
    false

  $("[href=#sign-out]").click ->
    navigator.id.logout()
    false

  navigator.id.watch
    loggedInUser: $("[data-current-user-email]").data("current-user-email"),
    onlogin: (assertion) ->
      console.log assertion
      # $.ajax
      #   type: 'POST'
      #   url: '/en/sign_in'
      #   data: { assertion: assertion }
      # .always ->
      #   window.location.reload()

    onlogout: ->
      # $.ajax
      #   type: 'POST',
      #   url: '/en/sign_out'
      # .always ->
      #   window.location.reload()
