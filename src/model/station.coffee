Coordinate = require './coordinate'

module.exports = class Station extends Coordinate
  constructor: (rawJson) ->
    super(rawJson)

    if rawJson.externalId?
      @externalId = rawJson.externalId
    if rawJson.externalStationNr?
      @externalStationNr = rawJson.externalStationNr
    if rawJson.puic?
      @puic = rawJson.puic
    if rawJson.prodclass?
      @prodclass = rawJson.prodclass
    if rawJson.urlname?
      @urlname = rawJson.urlname
