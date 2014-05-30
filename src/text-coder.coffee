bigint = require 'bigint'

class TextCoder
  constructor: (@symbols) ->
  
  encode: (text) ->
    multiplier = bigint 1
    sum = bigint 0
    for x in text
      index = @symbols.indexOf x
      throw new RangeError 'invalid symbol ' + x if index < 0
      sum = sum.add multiplier.mul index
      multiplier = multiplier.mul @symbols.length
    return sum
  
  decode: (number) ->
    if not number instanceof bigint
      throw new TypeError 'argument must be a bigint'
    result = []
    while not number.eq 0
      place = number.mod(@symbols.length).toNumber()
      number = number.div @symbols.length
      result.push @symbols[place]
    return result

module.exports = TextCoder
