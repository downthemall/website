#= require ui

$ ->

  $("section.donation .slider").each ->

    $slider = $(this)
    $gifts = $("ul.gifts li")
    $currency = $("#donation_currency")
    $amounts = $("ul.amounts li")
    $amount_label = $(".letter span.amount")
    $amount_description = $(".letter span.description")

    amount_donations = $slider.data("amounts")

    currency_symbols =
      USD: "$"
      EUR: "€"

    update = (e, ui) ->
      value = if ui then ui.value else $slider.slider("value")
      amount_donation = amount_donations[value]
      $gifts.removeClass("active").eq(value).addClass("active")
      $amounts.removeClass("active").eq(value).addClass("active")
      $amount_label.text(currency_symbols[$currency.val()] + amount_donation.amount)
      $amount_description.text(amount_donation.description)

    $slider.slider
      value: 2
      min: 0
      max: 5
      step: 1
      range: "min"
      slide: update

    $currency.change(update)

    update()

