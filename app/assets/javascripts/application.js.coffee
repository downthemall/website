#= require ./vendor/jquery
#= require_tree ./vendor
#= require plugin
#= require_tree ./plugins

$ ->
  $('[data-behaviour]').each ->
    new window[$(@).data('behaviour')](@)

  watch = ->
    navigator.id.watch
      loggedInUser: $("[data-current-user-email]").data("current-user-email")

      onlogin: (assertion) ->
        $.ajax
          type: 'POST'
          url: '/en/sign_in'
          data: { assertion: assertion }
        .done (data) ->
          document.location.reload() if data.success
        .fail (xhr, status, err) ->
          navigator.id.logout()

      onlogout: ->
        $.ajax
          type: 'POST',
          url: '/en/sign_out'
        .done (data) ->
          document.location.reload() if data.success
        .fail (xhr, status, err) ->
          alert("Logout failure: #{err}")

  $("[href=#sign-in]").click ->
    watch()
    navigator.id.request
      siteName: 'DownThemAll!'
      siteLogo: if location.protocol == 'https:' then '/assets/persona.png' else false
    false

  $("[href=#sign-out]").click ->
    watch()
    navigator.id.logout()
    false

