chai = require 'chai'
expect = chai.expect

Sbb = require "../lib/sbb"

describe "feature", ->
  it "should add two numbers", ->
    expect(2+2).to.equal 4

describe 'Sbb', ->
  describe '.getStation', ->

    it 'should get the station Chur when searching for Chur', (done) ->
      Sbb.getStation "Chur", (error, result) ->
        expect(result[0]).to.contain.keys 'name', 'externalId', 'externalStationNr', 'type', 'x', 'y'
        expect(result[0]).to.have.property 'name', 'Chur'
        done(error)

    it 'should get the station Maienfeld when searching for Maien', (done) ->
      Sbb.getStation "Maien", (error, result) ->
        expect(result[0]).to.contain.keys 'name', 'externalId', 'externalStationNr', 'type', 'x', 'y'
        expect(result[0]).to.have.property 'name', 'Maienfeld'
        done(error)

    it 'should get the station Zürich HB when searching for Zurich', (done) ->
      Sbb.getStation "Zurich", (error, result) ->
        expect(result[0]).to.contain.keys 'name', 'externalId', 'externalStationNr', 'type', 'x', 'y'
        expect(result[0]).to.have.property 'name', 'Zürich HB'
        done(error)

  describe '.getLocation', ->
    it 'should find Kino Apollo Chur', (done) ->
      Sbb.getLocation 'Kino Apollo Chur', (error, result) ->
        expect(result[0]).to.have.property 'name', 'Chur, Apollo (Kino)'
        done(error)

    it 'should finde Zürich HB by coordinates', (done) ->
      Sbb.getCoordinates 8540192, 47378177, (error, result) ->
        console.log result
        expect(result[0]).to.contain.keys 'name', 'externalId', 'externalStationNr', 'type', 'x', 'y'
        expect(result[0]).to.have.property 'name', 'Zürich HB'
        done(error)

  describe '.getConnection', ->
    it 'should get a connection from Chur to Maienfeld', (done) ->
      Sbb.getConnection 'Chur', 'Maienfeld', (error, result) ->
        expect(result).to.not.be.empty
        expect(result[0]).to.have.property 'from'
        expect(result[0].from).to.have.property 'name', 'Chur'
        expect(result[0]).to.have.property 'to'
        expect(result[0].to).to.have.property 'name', 'Maienfeld'
        expect(result[0]).to.have.property 'sections'
        done(error)

  describe '.getBoard', ->
    it 'should get a station board for Chur', (done) ->
      Sbb.getBoard 'Chur', (error, result) ->
        expect(result).to.be.not.empty
        expect(result[0]).to.contain.keys 'name', 'station', 'category', 'subcategory', 'number', 'to'
        done(error)
