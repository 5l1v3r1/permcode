bigint = require 'bigint'

factorial = (x) ->
  return bigint(1) if x <= 1
  return bigint(x).mul factorial(x - 1)

class Permutation
  constructor: (@list) ->
  
  tail: ->
    return new Permutation [] if @list.length <= 1
    value = @list[0]
    newList = []
    for x in @list[1..]
      newList.push if x < value then x else x - 1
    return new Permutation newList
  
  encode: ->
    index = @list[0]
    subValue = @tail().encode()
    addValue = bigint(index).mul factorial @list.length - 1
    return addValue.add subValue
  
  @decode: (number, length) ->
    return new Permutation [] if length is 0
    return new Permutation [0] if length is 1
    highestValue = number.div(factorial length - 1).toNumber()
    residualValue = number.mod factorial length - 1
    residual = @decode residualValue, length - 1
    remainingArray = (if x < highest then x else x + 1) for x in residual.list
    list = [highestValue].concat remainingArray
    return new Permutation list

module.exports = Permutation
