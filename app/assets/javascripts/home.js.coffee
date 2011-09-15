$(document).ready ->

  ## Home Features Tabs ##
  $feature_links = $("section.home-features nav a")
  $features = $("section.home-features section.feature")

  $feature_links.click ->
    $feature_to_show = $($(this).attr("href"))
    $(".scroller").slideUp ->
      $features.hide()
      $feature_to_show.show()
      $(".scroller").slideDown()
    $feature_links.removeClass("selected")
    $(this).addClass("selected")

  $feature_links.eq(0).click()

  ## Home Reviews ##

  $(".home-reviews li a").tipsy
    className: "home-review"
    gravity: $.fn.tipsy.autoNS
    fade: yes
    opacity: 1
    html: yes
    title: ->
      quote = $("<div/>").addClass("quote").text $(this).data("quote")
      source = $("<div/>").addClass("source").text $(this).text()
      $("<div/>").append(quote).append(source).html()
