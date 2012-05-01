Walk = require './walk'
Journey = require './journey'
Station = require './station'

class Section
  constructor: (rawJson) ->
    @departure = new Station(rawJson.Departure.BasicStop)
    @arrival = new Station(rawJson.Arrival.BasicStop)

    if rawJson.Journey?
      @journey = new Journey(rawJson.Journey)

    if rawJson.Walk?
      @walk = new Walk(rawJson.Walk)

module.exports = Section