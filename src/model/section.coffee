Walk = require './walk'
Journey = require './journey'
Stop = require './stop'

module.exports = class Section
  constructor: (rawJson) ->
    @departure = new Stop(rawJson.Departure.BasicStop)
    @arrival = new Stop(rawJson.Arrival.BasicStop)

    if rawJson.Journey?
      @journey = new Journey(rawJson.Journey)

    if rawJson.Walk?
      @walk = new Walk(rawJson.Walk)
