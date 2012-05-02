request = require 'request'
Futures = require 'futures'
{Parser} = require 'xml2js'
Util = require './util'
Query = require './query'
Connection = require './model/connection'
Transportation = require './model/transportation'

module.exports = class ConnectionQuery extends Query
  DATE_TYPES =
    departure: 0
    arrival: 1

  SEARCH_MODES =
    normal: 'N'
    economic: 'P'

  defaults =
    via: []
    time: new Date()
    transportations: 'all'
    changeCount: -1
    changePercent: -1
    limit: 4
    direct: false
    sleeper: false
    couchette: false
    bike: false

  forStations: (@from, @to, @options = defaults) ->
    Util.deepExtend(@options, defaults)

    @trans = Transportation.reduce(@options.transportations)
    @request = @beginXml().element('ConReq')

    @options.limit = 4 if not 0 < @options.limit < 7
    @options.changePercent = -1 if not 0 <= @options.changePercent <= 1

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
        req =
          uri: @XML_URI
          method: 'POST'
          headers: @XML_HEADERS
          body: @request.doc().toString()

        request(req, next)
      .then (next, err, response, body) =>
        if err? then return callback(err)

        parser = new Parser(mergeAttrs: true)
        parser.parseString(body, next)
      .then (next, err, json) =>
        if err? then return callback(err)

        connections = json.ConRes.ConnectionList.Connection

        if not Array.isArray connections
          connections = [connections]

        callback err, connections.map (connection) -> new Connection(connection)

  addStart: ->
    start =
      @request.element('Start')
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
        @request
        .element('Via')
          .element('Prod', @trans)
          .up()
          .element('Station')
            .attribute('name', via.name)
            .attribute('externalId', via.externalId)

  addDestination: ->
    destination =
      @request
      .element('Dest')
        .element('Prod', @trans)
        .up()
        .element('Station')
          .attribute('name', @to.name)
          .attribute('externalId', @to.externalId)

  addTime: ->
    time =
      @request
      .element('ReqT')
        .attribute('a', DATE_TYPES.departure)
        .attribute('date', Util.dateToYmd(@options.time))
        .attribute('time', Util.dateToHHmm(@options.time))

  addFlags: ->
    flags =
      @request
      .element('RFlags')
        .attribute('b', 0)
        .attribute('f', @options.limit)
        .attribute('sMode', SEARCH_MODES.normal)

    if @options.changeCount > -1
      flags.attribute('nrChanges', @options.changeCount)

    if 0 <= @options.changePercent <= 1
      flags.attribute('chExtension', @options.changePercent)
