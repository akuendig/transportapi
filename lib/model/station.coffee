Coordinate = require './coordinate'

class Station extends Coordinate
  constructor: (rawJson) ->
    super(rawJson)

    @name = rawJson.name
    @externalId = rawJson.externalId

module.exports = Station
