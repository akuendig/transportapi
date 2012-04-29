chai = require 'chai'
expect = chai.expect

Sbb = require "../lib/sbb"

describe "feature", ->
  it "should add two numbers", ->
    expect(2+2).to.equal 4

describe 'Sbb', ->
  describe '.findStation', ->

    it '("Chur") should find the station Chur', (done) ->
      sbb = new Sbb()
      body = sbb.findStation "Chur", (error, result) ->
        expect(result[0]).to.contain.keys 'name', 'externalId', 'externalStationNr', 'type', 'x', 'y'
        expect(result[0]).to.have.property 'name', 'Chur'
        done(error)

    it '("Maien", "station") should find the station Maienfeld', (done) ->
      sbb = new Sbb()
      body = sbb.findStation "Maien", (error, result) ->
        expect(result[0]).to.contain.keys 'name', 'externalId', 'externalStationNr', 'type', 'x', 'y'
        expect(result[0]).to.have.property 'name', 'Maienfeld'
        done(error)

    it '("Zurich") should find the station Zürich HB', (done) ->
      sbb = new Sbb()
      body = sbb.findStation "Zurich", (error, result) ->
        expect(result[0]).to.contain.keys 'name', 'externalId', 'externalStationNr', 'type', 'x', 'y'
        expect(result[0]).to.have.property 'name', 'Zürich HB'
        done(error)
