chai = require 'chai'
expect = chai.expect

Util = require "../lib/util"

describe 'Util', ->
  describe '.parseOffsetTime', ->
    it "should parse 00d00:10:20", ->
      time = new Date()
      time.setHours 0
      time.setMinutes 10
      time.setSeconds 20
      expect(Util.parseOffsetTime('00d00:10:20').toLocaleString()).to.equal time.toLocaleString()

    it "should parse 01d10:10:00", ->
      time = new Date()
      time.setDate time.getDate() + 1
      time.setHours 10
      time.setMinutes 10
      time.setSeconds 0
      expect(Util.parseOffsetTime('01d10:10:00').toLocaleString()).to.equal time.toLocaleString()

  describe '.parseYmdDate', ->
    it 'should parse 20110330', ->
      time = new Date 2011, 3, 30
      expect(Util.parseYmdDate('20110330').toLocaleString()).to.equal time.toLocaleString()

  describe '.isArray', ->
    it 'should return true for [], [1, 2, 3], [{}] and "Hello"', ->
      expect(Util.isArray []).to.be.true
      expect(Util.isArray [1, 2, 3]).to.be.true
      expect(Util.isArray [{}]).to.be.true

    it 'should return false for null and {}', ->
      expect(Util.isArray(null)).to.be.false
      expect(Util.isArray({})).to.be.false
