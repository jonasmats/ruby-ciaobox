$('#home_banner_submit').click ->
  $.ajax
    method: 'POST'
    url: $('#home_banner_url').val()
    data: {zip_code: $('#home_banner_zip_code').val()}
    success: (result, statusText, xhr) ->
      if result.code == 100
        if result.data == "standard"
          window.location.href = "/shipping/standard/appoinment";
        else if result.data == "fly"
          window.location.href = "/shipping/fly/appoinment";
      else if result.code == 200
        $('#zip_code_modal').modal
          backdrop: false
          keyboard: true
      else if result.code == 300
        alert result.data

    error: (response) ->
      console.log response
      alert(response.responseText)

$('#zipcode_modal_submit').click ->
  $.ajax
    method: 'POST'
    url: '/v1/newsletters'
    data: $('#zip_code_modal_form').serialize()
    success: (result, statusText, xhr) ->
      if result.code == 100
        $('#zip_code_modal').modal 'hide'
      else if result.code == 200
        alert result.data
      else if result.code == 300
        alert result.data

    error: (response) ->
      console.log response
      alert(response.responseText)