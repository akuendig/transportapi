Query = require './query'
Futures = require 'futures'
{Parser} = require 'xml2js'

class LocationQuery extends Query
  SBB_SEARCH = 1
  LOCATION_TYPES =
    all: 'ALLTYPE'
    station: 'ST'
    address: 'ADR'
    poi: 'POI'

  forStation: (name, type = 'all') ->
    @root
      .element('LocValReq')
        .attribute('id', 'station')
        .attribute('sMode', SBB_SEARCH)
        .element('ReqLoc')
          .attribute('match', name)
          .attribute('type', LOCATION_TYPES[type])

    return this;

  get: (callback) ->
    Futures
      .sequence()
      .then (next) =>
        @request next
      .then (next, err, response, body) ->
        parser = new Parser()
        parser.parseString body, next
      .then (next, err, json) ->
        stations = (a) ->
        callback(err, json.LocValRes.Station)
        # callback(err, json.LocValRes.Station['@'])

module.exports = LocationQuery
