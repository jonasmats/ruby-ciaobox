$('#submit_inquiry').click ->
  $.ajax
    method: 'POST'
    url: $('#submit_inquiry_url').val()
    data: {
      contact_name: $('#contact_name').val(),
      email_from: $('#email_from').val(),
      subject: $('#subject').val(),
      contact_phone: $('#contact_phone').val(),
      message: $('#message').val()
    }
    success: (result, statusText, xhr) ->
      if result.code == 100
        alert result.data
      else if result.code == 200
        alert result.data
      else if result.code == 300
        alert result.data

    error: (response) ->
      console.log response
      alert(response.responseText)