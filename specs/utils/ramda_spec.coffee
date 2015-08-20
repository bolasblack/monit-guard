R = require 'ramda'
require 'app/utils/ramda'

describe 'Ramda', ->
  # String -> a -> {k: v} -> {k: v}
  describe 'assocAppend', ->
    it 'return a new object contains the list which the given element appended', ->
      result = R.assocAppend 'a', 'b', a: [1, 2, 3]
      expect(result).eql a: [1, 2, 3, 'b']

  # String -> (a -> Boolean) -> {k: v} -> {k: v}
  describe 'assocDrop', ->
    it 'return a new object contains the list which droped the predicate function matched element', ->
      predicate = sinon.spy R.equals(2)
      result = R.assocDrop 'a', predicate, a: [1, 2, 3]
      expect(predicate).calledThrice.and.have.property('args').eql [[1], [2], [3]]
      expect(result).eql a: [1, 3]

  # (a -> b) -> (a -> Boolean) -> [a] -> [a]
  describe 'mapReplace', ->
    it 'return a new list which replaced the predicate function matched element', ->
      replacer = sinon.spy R.always(2)
      predicate = sinon.spy R.equals(3)
      result = R.mapReplace replacer, predicate, [1, 2, 3]
      expect(replacer).calledOnce.and.have.property('args').eql [[3]]
      expect(predicate).calledThrice.and.have.property('args').eql [[1], [2], [3]]
      expect(result).eql [1, 2, 2]
