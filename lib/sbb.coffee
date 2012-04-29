{Parser} = require 'xml2js'
Futures = require 'futures'
LocationQuery = require './locationQuery'

class Sbb
  findStation: (name, callback) ->
    query = new LocationQuery()
    query.forStation(name).get callback

  findConnection: (from, to, callback) ->
    join = Futures.join()

    findStation from, join.add()
    findStation to, join.add()

    join.when (stationFrom, stationTo) ->


    stationFrom = new ConnectionQuery()

module.exports = Sbb
