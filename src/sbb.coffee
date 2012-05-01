Futures = require 'futures'
LocationQuery = require './locationQuery'
ConnectionQuery = require './connectionQuery'

module.exports = class Sbb
  findStation: (name, callback) ->
    query = new LocationQuery()
    query.forStation(name, 'station').get callback

  findConnection: (from, to, callback) ->
    join = Futures.join()

    @findStation from, join.add()
    @findStation to, join.add()

    join.when (fromResult, toResult) ->
      query = new ConnectionQuery()

      # fromResult[0] and toResult[0] are the error
      query.forStations(fromResult[1][0], toResult[1][0]).get callback
