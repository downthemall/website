#= require ./vendor/jquery
#= require_tree ./vendor
#= require plugin
#= require_tree ./plugins

$ ->
  $('[data-behaviour]').each ->
    new window[$(@).data('behaviour')](@)

  $("[href=#sign-in]").click ->
    navigator.id.request
      siteName: 'DownThemAll!'
      siteLogo: if location.protocol == 'https:' then '/assets/persona.png' else false
    false

  $("[href=#sign-out]").click ->
    navigator.id.logout()
    false

  navigator.id.watch
    loggedInUser: $("[data-current-user-email]").data("current-user-email")

    onlogin: (assertion) ->
      $.ajax
        type: 'POST'
        url: '/en/sign_in'
        data: { assertion: assertion }
      .done (data) ->
        if data.success
          alert('Sign in!') if data.changed
        else
          alert('Login failure')
      .fail (xhr, status, err) ->
        navigator.id.logout()

    onlogout: ->
      $.ajax
        type: 'POST',
        url: '/en/sign_out'
      .done (data) ->
        alert('Sign out!') if data.changed
      .fail (xhr, status, err) ->
        alert("Logout failure: #{err}")

