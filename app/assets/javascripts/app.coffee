$('#show-footer-buttons').click (e) ->
  e.preventDefault()
  $('#add-maintenances-bar').removeClass('hide')
  return
$('#hide-footer-buttons').click (e) ->
  e.preventDefault()
  $('#add-maintenances-bar').addClass('hide')
  return