$ ->

  $tab_scope_contents = {}

  $("[data-behaviour=tab]").each ->
    $tab = $(this)
    $tab_content = $($tab.attr("href") || $tab.find("a").attr("href")).hide()
    scope = $tab.data("tab-scope")
    $related_tabs = $("[data-tab-scope=#{scope}]")
    $tab_scope_contents[scope] = ($tab_scope_contents[scope] || $()).add $tab_content

    $tab.click ->
      $related_tabs.removeClass("selected-tab")
      $tab.addClass("selected-tab")
      $tab_scope_contents[scope].hide()
      $tab_content.show()
      false

    $related_tabs.eq(0).click()

