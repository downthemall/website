#= require jquery
#= require jquery-ujs
#= require base_plugin
#= require_tree ./plugins

$ ->
  $('[data-behaviour]').each ->
    new window[$(@).data('behaviour')](@)

