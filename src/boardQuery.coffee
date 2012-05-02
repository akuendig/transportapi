Futures = require 'futures'
{Parser} = require 'xml2js'
Util = require './util'
Query = require './query'
Journey = require './model/journey'
Transportation = require './model/transportation'

module.exports = class BoardQuery extends Query
  DATE_TYPES =
    departure: 'DEP'
    arrival: 'ARR'

  defaults =
    type: 'departure'
    limit: 40
    time: new Date()
    transportations: 'all'

  forStation: (@station, @options = defaults) ->
    Util.deepExtend(@options, defaults)
    @options.limit = 20 if not 0 < @options.limit < 50

    board =
      @root
      .element('STBReq')
        .attribute('dateType', DATE_TYPES[@options.type])
        .attribute('maxJourneys', @options.limit)

    board
      .element('Time', Util.dateToHHmm(@options.time))
      .up()
      .element('Period')
        .element('DateBegin')
          .element('Date', Util.dateToYmd(@options.time))
          .up()
        .up()
        .element('DateEnd')
          .element('Date', Util.dateToYmd(@options.time))
          .up()
        .up()
      .up()
      .element('TableStation')
        .attribute('externalId', @station.externalId)
      .element('ProductFilter')
        .attribute('ProductFilter', Transportation.reduce(@options.transportations))

    return this

  get: (callback) ->
    return if not typeof callback is 'function'

    Futures
      .sequence()
      .then (next) =>
        @request(next)
      .then (next, err, response, body) =>
        if err? then return callback(err)

        parser = new Parser(mergeAttrs: true)
        parser.parseString(body, next)
      .then (next, err, json) =>
        if err? then return callback(err)

        results = json.STBRes.JourneyList.STBJourney
        if not Array.isArray(results)
          results = [results]

        callback(err, results.map (entry) -> new Journey(entry))
