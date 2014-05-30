bigint = require 'bigint'

class Permutation
  constructor: (@list) ->
  
  tail: ->
    return new Permutation [] if @list.length <= 1
    value = @list[0]
    newList = (if x < value then x else x - 1 for x in @list[1..])
    return new Permutation newList
  
  encode: ->
    index = @list[0]
    childValue = @tail().encode()
    addValue = bigint(index).mul Permutation.factorial @list.length - 1
    return addValue.add childValue
  
  @decode: (number, length) ->
    return new Permutation [] if length is 0
    return new Permutation [0] if length is 1
    highest= number.div(@factorial length - 1).toNumber()
    residualValue = number.mod @factorial length - 1
    residual = @decode residualValue, length - 1
    remainingArray = (if x < highest then x else x + 1 for x in residual.list)
    list = [highest].concat remainingArray
    return new Permutation list
  
  @factorial: (x) ->
    return bigint(1) if x <= 1
    return bigint(x).mul @factorial(x - 1)

module.exports = Permutation
