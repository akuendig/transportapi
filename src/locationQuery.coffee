Util = require './util'
Query = require './query'
Station = require './model/station'
Coordinate = require './model/coordinate'
Futures = require 'futures'
{Parser} = require 'xml2js'

module.exports = class LocationQuery extends Query
  SBB_SEARCH = 1
  LOCATION_TYPES =
    all: 'ALLTYPE'
    station: 'ST'
    address: 'ADR'
    poi: 'POI'

  forName: (name, type = 'all') ->
    @request =
      @beginXml()
      .element('LocValReq')
        .attribute('id', 'station')
        .attribute('sMode', SBB_SEARCH)
        .element('ReqLoc')
          .attribute('match', name)
          .attribute('type', LOCATION_TYPES[type])

    return this;

  defaults =
    limit: 20
    distance: 5000

  forCoordinates: (x, y, options = defaults)->
    Util.deepExtend(options, defaults)

    @isJson = true
    @request =
      'performLocating': 2
      'tpl': 'stop2json'
      'look_maxno': options.limit
      'look_stopclass': 1023 # all, 1<<10 - 1
      'look_maxdist': options.distance
      'look_y': x
      'look_x': y

    return this;

  get: (callback) ->
    return if not typeof callback is 'function'

    return @getJson(callback) if @isJson

    Futures
      .sequence()
      .then (next) =>
        @fetch(next)
      .then (next, err, response, body) ->
        if err? then return callback(err)

        parser = new Parser(mergeAttrs: true)
        parser.parseString(body, next)
      .then (next, err, json) ->
        if err? then return callback(err)

        pois = json.LocValRes.Poi ? []
        pois = [pois] if not Array.isArray pois
        pois = pois.map (st) -> new Coordinate(st)

        stations = json.LocValRes.Station ? []
        stations = [stations] if not Array.isArray stations
        stations = stations.map (st) -> new Station(st)

        addresses = json.LocValRes.Address ? []
        addresses = [addresses] if not Array.isArray addresses
        addresses = addresses.map (st) -> new Coordinate(st)

        callback(err, pois.concat(stations).concat(addresses))

  getJson: (callback) ->
    return if not typeof callback is 'function'

    Futures
      .sequence()
      .then (next) =>
        @fetch(next)
      .then (next, err, response, body) ->
        callback(err, body)
