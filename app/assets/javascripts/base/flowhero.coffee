window.Flowhero =
  init: ->
    $(document).ready () ->
      $('.button-collapse').sideNav()
      $('.flash').each (index, flash) ->
        $flash = $(flash)
        msg    = $flash.html()
        fclass = $flash.attr('class').replace(/flash|hide| /g,'')
        Materialize.toast(msg, 3000, fclass)
        
