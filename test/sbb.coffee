require "should"
Sbb = require "../lib/sbb"

describe "feature", ->
  it "should add two numbers", ->
    (2+2).should.equal 4

describe "SBB", ->
  it "test", (done) ->
    sbb = new Sbb()
    sbb.queryConnection "Chur", "Maienfeld", (error, result) ->
      result.should.equal("Hello")
      done()
