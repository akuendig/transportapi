require "should"
Sbb = require "../lib/sbb"

describe "feature", ->
  it "should add two numbers", ->
    (2+2).should.equal 4

describe "SBB", ->
  it "test", ->
    sbb = new Sbb()
    body = sbb.buildBody("Chur", "Maienfeld")
    console.log body
    body.should.equal("Hello")