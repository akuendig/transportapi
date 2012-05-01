Futures = require 'futures'
{Parser} = require 'xml2js'
Util = require './util'
Query = require './query'
Connection = require './model/connection'

class ConnectionQuery extends Query
  DATE_TYPE_DEPARTURE = 0
  DATE_TYPE_ARRIVAL = 1

  SEARCH_MODE_NORMAL = 'N'
  SEARCH_MODE_ECONOMIC = 'P'

  forStations: (from, to) ->
    connection = @root.element('ConReq')

    @addStart(connection, from)
    @addDestination(connection, to)
    @addTime(connection)
    @addFlags(connection)

    return this

  get: (callback) ->
    Futures
      .sequence()
      .then (next) =>
        @request next
      .then (next, err, response, body) ->
        if err? then callback err

        parser = new Parser mergeAttrs: true
        parser.parseString body, next
      .then (next, err, json) ->
        if err? then callback err

        connections = json.ConRes.ConnectionList.Connection

        if not Util.isArray connections
          connections = [connections]

        callback err, connections.map (connection) -> new Connection(connection)

  addStart: (parent, from) ->
    parent
      .element('Start')
        .element('Station')
          .attribute('name', from.name)
          .attribute('externalId', from.externalId)
        .up()
        .element('Prod', '1111111111111111').up()
      .up()

  addDestination: (parent, to) ->
    parent
      .element('Dest')
        .element('Station')
          .attribute('name', to.name)
          .attribute('externalId', to.externalId)
        .up()
        .element('Prod', '1111111111111111').up()
      .up()

  addTime: (parent) ->
    date = new Date()

    year = date.getFullYear().toString()

    month = date.getMonth().toString()
    month = '0' + month if month.length is 1

    day = date.getDate().toString()
    day = '0' + day if day.length is 1

    parent
      .element('ReqT')
      .attribute('a', DATE_TYPE_DEPARTURE)
      .attribute('date', year + month + day)
      .attribute('time', date.getHours() + ':' + date.getMinutes())
      .up()

  addFlags: (parent) ->
    parent
      .element('RFlags')
      .attribute('b', 0)
      .attribute('f', 4)
      .attribute('sMode', SEARCH_MODE_NORMAL)
      .up()

module.exports = ConnectionQuery