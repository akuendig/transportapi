chai = require 'chai'
expect = chai.expect

Sbb = require "../lib/sbb"

describe "feature", ->
  it "should add two numbers", ->
    expect(2+2).to.equal 4

describe 'Sbb', ->
  describe '.findStation', ->

    it 'should find the station Chur when searching for Chur', (done) ->
      sbb = new Sbb()
      sbb.findStation "Chur", (error, result) ->
        expect(result[0]).to.contain.keys 'name', 'externalId', 'externalStationNr', 'type', 'x', 'y'
        expect(result[0]).to.have.property 'name', 'Chur'
        done(error)

    it 'should find the station Maienfeld when searching for Maien', (done) ->
      sbb = new Sbb()
      sbb.findStation "Maien", (error, result) ->
        expect(result[0]).to.contain.keys 'name', 'externalId', 'externalStationNr', 'type', 'x', 'y'
        expect(result[0]).to.have.property 'name', 'Maienfeld'
        done(error)

    it 'should find the station Zürich HB when searching for Zurich', (done) ->
      sbb = new Sbb()
      sbb.findStation "Zurich", (error, result) ->
        expect(result[0]).to.contain.keys 'name', 'externalId', 'externalStationNr', 'type', 'x', 'y'
        expect(result[0]).to.have.property 'name', 'Zürich HB'
        done(error)

  describe '.findConnection', ->

    it 'should find a connection from Chur to Maienfeld', (done) ->
      sbb = new Sbb()
      sbb.findConnection 'Chur', 'Maienfeld', (error, result) ->
        expect(result).to.not.be.empty
        expect(result[0]).to.have.property 'from'
        expect(result[0].from).to.have.property 'name', 'Chur'
        expect(result[0]).to.have.property 'to'
        expect(result[0].to).to.have.property 'name', 'Maienfeld'
        expect(result[0]).to.have.property 'sections'
        done(error)

