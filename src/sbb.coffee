Futures = require 'futures'
BoardQuery = require './boardQuery'
LocationQuery = require './locationQuery'
ConnectionQuery = require './connectionQuery'

namespace = exports ? this

namespace.getLocation = (name, callback) ->
  query = new LocationQuery()
  query.forName(name).get(callback)

namespace.getCoordinates = (x, y, callback) ->
  query = new LocationQuery()
  query.forCoordinates(x, y).get(callback)

namespace.getStation = (name, callback) ->
  query = new LocationQuery()
  query.forName(name, 'station').get(callback)

namespace.getAddress = (name, callback) ->
  query = new LocationQuery()
  query.forName(name, 'address').get(callback)

namespace.getPoi = (name, callback) ->
  query = new LocationQuery()
  query.forName(name, 'poi').get(callback)

namespace.getBoard = (name, callback) ->
  Futures
    .sequence()
    .then (next) =>
      @getStation(name, next)
    .then (next, err, results) =>
      query = new BoardQuery()
      query.forStation(results[0]).get(next)
    .then (next, err, result) =>
      callback(err, result)

namespace.getConnection = (from, to, callback) ->
  join = Futures.join()

  @getStation(from, join.add())
  @getStation(to, join.add())

  join.when (fromResult, toResult) ->
    query = new ConnectionQuery()

    # fromResult[0] and toResult[0] are the error
    query.forStations(fromResult[1][0], toResult[1][0]).get(callback)
