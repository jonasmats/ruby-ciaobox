$('#btn-backup-db').click ->
  $.ajax
    method: 'POST'
    url: $('#backup_db_url').val()
    data: {executable: '1'}
    success: (result, statusText, xhr) ->
      log_item = $('#backup_log').val();
      if log_item != null && log_item != undefined && log_item != ''
        $('#backup_log').val(log_item + '\n' + result.data);
      else
        $('#backup_log').val(result.data);

    error: (response) ->
      console.log response
      alert(response.responseText)