require "should"
Sbb = require "../lib/sbb"

describe "feature", ->
  it "should add two numbers", ->
    (2+2).should.equal 4

describe 'Sbb', ->
  describe '.findStation', ->

    it '("Chur") should find the station Chur', (done) ->
      sbb = new Sbb()
      body = sbb.findStation "Chur", (error, result) ->
        result.should.have.property 'name', 'Chur'
        done(error)

    it '("Maien", "station") should find the station Maienfeld', (done) ->
      sbb = new Sbb()
      body = sbb.findStation "Maien", (error, result) ->
        result.should.have.property 'name', 'Maienfeld'
        done(error)

    # it '("Zurich") should find the station Zürich HB', (done) ->
    #   sbb = new Sbb()
    #   body = sbb.findStation "Zurich", (error, result) ->
    #     have.property 'name', 'Zürich HB'
    #     done(error)
