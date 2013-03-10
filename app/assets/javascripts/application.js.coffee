#= require ./vendor/jquery
#= require_tree ./vendor
#= require plugin
#= require_tree ./plugins

$ ->
  $('[data-behaviour]').each ->
    new window[$(@).data('behaviour')](@)

