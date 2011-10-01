#= require portamento

$ ->
  $("[data-behaviour=sliding]").each ->
    $(this).portamento
      wrapper: $(this).parent("[data-behaviour=sliding-limiter]")
      gap: 40

