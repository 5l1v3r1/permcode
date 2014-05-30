bigint = require 'bigint'
TextCoder = require './text-coder'
Permutation = require './permutation'

class Coder
  constructor: (symbols, @permChars) ->
    @textCoder = new TextCoder symbols
  
  encode: (msg) ->
    number = @textCoder.encode msg
    i = 1
    i++ while Permutation.factorial(i) <= number
    if i > @permChars.length
      throw new RangeError 'not enough permutation characters'
    perm = Permutation.decode number, i
    return (@permChars[x] for x in perm.list)
  
  decode: (chars) ->
    list = []
    for x in chars
      index = @permChars.indexOf x
      throw new RangeError 'unknown perm char ' + x if index < 0
      list.push index
    perm = new Permutation list
    number = perm.encode()
    return @textCoder.decode number

module.exports = Coder
