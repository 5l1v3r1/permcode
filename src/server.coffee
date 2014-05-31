express = require 'express'
fs = require 'fs'
Coder = require './coder'

if process.argv.length isnt 3
  console.log 'Usage: coffee src/server.coffee <port>'
  process.exit 1

alphabet = 'abcdefghijklmnopqrstuvwxyz'
allChars = alphabet + alphabet.toUpperCase() + '",<.>!@#$%^&*(){}1234567890\' '

app = express()
app.use '/assets', express.static __dirname + '/../assets'
app.get '/', (req, res) ->
  fs.readFile __dirname + '/../assets/index.html', (err, data) ->
    return res.send 500, 'Failed to read index.html' if err?
    res.send data.toString()
app.get '/convert', (req, res) ->
  if typeof req.query.str isnt 'string'
    return res.send JSON.stringify error: 'invalid str argument'
  if typeof req.query.outtype isnt 'string'
    return res.send JSON.stringify error: 'invalid outtype argument'
  if not req.query.outtype in ['perm', 'text']
    return res.send JSON.stringify error: 'invalid outtype argument'
  coder = new Coder allChars, allChars
  try
    if req.query.outtype is 'perm'
      result = result: coder.encode(req.query.str).join ''
    else
      result = result: coder.decode(req.query.str).join ''
  catch e
    return res.send JSON.stringify error: e.toString()
  res.send JSON.stringify result
    
app.listen parseInt process.argv[2]
