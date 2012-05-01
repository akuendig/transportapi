Coordinate = require './coordinate'

module.exports = class Station extends Coordinate
  constructor: (rawJson) ->
    super(rawJson)

    @externalId = rawJson.externalId
    @externalStationNr = rawJson.externalStationNr
