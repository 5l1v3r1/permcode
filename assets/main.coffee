sendReq = (url, cb) ->
  req = $.getJSON url, (obj) ->
    if obj.error?
      return cb new Error obj.error
    cb null, obj.result
  req.fail ->
    cb new Error 'failed to make request'

mainCB = (err, str) ->
  return alert err.toString() if err?
  $('#data').val str

window.convertToPerm = ->
  theURL = 'convert?str=' + encodeURIComponent($('#data').val()) +
    '&outtype=perm'
  sendReq theURL, mainCB

window.convertToText = ->
  theURL = 'convert?str=' + encodeURIComponent($('#data').val()) +
    '&outtype=text'
  sendReq theURL, mainCB
