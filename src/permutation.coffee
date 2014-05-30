bigint = require 'bigint'

class Permutation
  constructor: (@list) ->
  
  tail: ->
    return new Permutation [] if @list.length <= 1
    value = @list[0]
    newList = []
    for x in @list[1..]
      if x < value
        newList.push x
      else
        newList.push x - 1
    return new Permutation newList
  
  encode: ->
    return bigint 0 if @list.length <= 1
    index = @list[0]
    childValue = @tail().encode()
    addValue = bigint(index).mul Permutation.factorial @list.length - 1
    return addValue.add childValue
  
  @decode: (number, length) ->
    return new Permutation [] if length is 0
    return new Permutation [0] if length is 1
    highest = number.div(@factorial length - 1).toNumber()
    residual = number.mod @factorial length - 1
    list = @decode(residual, length - 1).list
    remaining = [highest]
    for x in list
      if x < highest
        remaining.push x
      else
        remaining.push x + 1
    return new Permutation remaining
  
  @factorial: (x) ->
    return bigint(1) if x <= 1
    return bigint(x).mul @factorial(x - 1)

module.exports = Permutation
