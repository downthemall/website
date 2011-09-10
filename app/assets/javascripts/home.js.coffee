$(document).ready ->

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