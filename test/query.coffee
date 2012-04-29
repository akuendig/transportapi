chai = require 'chai'
expect = chai.expect

Query = require "../lib/query"

describe 'Query', ->
  describe '.isArray', ->
    it 'should return true for [], [1, 2, 3], [{}] and "Hello"', ->
      query = new Query()
      expect(query.isArray []).to.be.true
      expect(query.isArray [1, 2, 3]).to.be.true
      expect(query.isArray [{}]).to.be.true

    it 'should return false for null and {}', ->
      query = new Query()
      expect(query.isArray(null)).to.be.false
      expect(query.isArray({})).to.be.false
