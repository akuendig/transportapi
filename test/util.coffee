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
