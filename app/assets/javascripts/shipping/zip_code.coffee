$('#home_banner_submit').click ->
  $.ajax
    method: 'POST'
    url: $('#home_banner_form').attr 'action'
    data: $('#home_banner_form').serialize()
    success: (result, statusText, xhr) ->
      if result.code == 100
        if result.data == "standard"
          window.location.href = "/shipping/standard";
        else if result.data == "fly"
          window.location.href = "/shipping/fly";
      else if result.code == 200
        alert result.data
      else if result.code == 300
        alert result.data

    error: (response) ->
      console.log response
      alert(response.responseText)