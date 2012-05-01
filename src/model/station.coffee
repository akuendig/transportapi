Coordinate = require './coordinate'

module.exports = class Station extends Coordinate
  constructor: (rawJson) ->
    super(rawJson)

    @name = rawJson.name
    @externalId = rawJson.externalId
    @externalStationNr = rawJson.externalStationNr
