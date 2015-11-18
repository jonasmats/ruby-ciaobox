$ ->
  $("ul.nav-tabs li").on "click", ->
    tab_current = $(@).find("a").attr("href")
    $(".tab-pane").each ->
      $(@).addClass("hidden")
      element_current = "#" + $(@).attr("id")
      if element_current == tab_current
        $(@).removeClass("hidden")
