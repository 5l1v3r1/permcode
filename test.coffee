Coder = require './src/coder'

alphabet = 'abcdefghijklmnopqrstuvwxyz'
alphas = alphabet.toUpperCase() + alphabet
allChars = alphas + ' .'

c = new Coder allChars, alphas
encoded = c.encode 'hey'
console.log 'encode("hey") = "' + encoded.join('') + '"'
console.log '"hey" = "' + c.decode(encoded).join('') + '"'
