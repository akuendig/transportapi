Futures = require 'futures'
{Parser} = require 'xml2js'
Query = require './query'
Connection = require './model/connection'
Transportation = require './model/transportation'

module.exports = class ConnectionQuery extends Query
  DATE_TYPE_DEPARTURE = 0
  DATE_TYPE_ARRIVAL = 1

  SEARCH_MODE_NORMAL = 'N'
  SEARCH_MODE_ECONOMIC = 'P'

  defaults =
    via: []
    time: new Date()
    transportations: 'all'
    changeCount: -1
    limit: 4
    direct: false
    sleeper: false
    couchette: false
    bike: false

  forStations: (from, to, options = defaults) ->
    @to = to
    @from = from
    @trans = Transportation.reduce(options.transportations)
    @options = options
    @connection = @root.element('ConReq')

    @addStart()
    @addDestination()
    @addTime()
    @addFlags()

    return this

  get: (callback) ->
    return if not typeof callback is 'function'

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

        if not Array.isArray connections
          connections = [connections]

        callback err, connections.map (connection) -> new Connection(connection)

  addStart: ->
    start =
      @connection.element('Start')
    prod =
      start.element('Prod', @trans)
    station =
      start
      .element('Station')
        .attribute('name', @from.name)
        .attribute('externalId', @from.externalId)

    if @options.direct then prod.attribute('direct', 1)
    if @options.sleeper then prod.attribute('sleeper', 1)
    if @options.couchette then prod.attribute('couchette', 1)
    if @options.bike then prod.attribute('bike', 1)

  addVia: ->
    for via in options.via
      via =
        @connection.element('Via')
      prod =
        via.element('Prod', @trans)
      station =
        via
        .element('Station')
          .attribute('name', via.name)
          .attribute('externalId', via.externalId)

  addDestination: ->
    destination =
      @connection.element('Dest')
    prod =
      station.element('Prod', @trans)
    station =
      destination
        .element('Station')
          .attribute('name', to.name)
          .attribute('externalId', to.externalId)

  addTime: ->
    date = new Date()

    year = date.getFullYear().toString()

    month = date.getMonth().toString()
    month = '0' + month if month.length is 1

    day = date.getDate().toString()
    day = '0' + day if day.length is 1

    time =
      @connection
      .element('ReqT')
        .attribute('a', DATE_TYPE_DEPARTURE)
        .attribute('date', year + month + day)
        .attribute('time', date.getHours() + ':' + date.getMinutes())

  addFlags: ->
    flags =
      @connection
      .element('RFlags')
        .attribute('b', 0)
        .attribute('f', 4)
        .attribute('sMode', SEARCH_MODE_NORMAL)

    if @options.changeCount > -1
      flags.attribute('nrChanges', @options.changeCount)

    if 0 < @options.changeExtensionPercent < 1
      flags.attribute('chExtension', @options.changeExtensionPercent)

