chai = require 'chai'
expect = chai.expect

Transportation = require './../lib/model/transportation'

describe 'Transportation', ->
  describe '.reduce', ->
    it 'should handle many parameters correctly', ->
      res = Transportation.reduce('bus', 'ship')
      expect(res).to.equal 2560
