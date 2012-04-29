Query = require "query"

class ConnectionQuery extends Query
  DATE_TYPE_DEPARTURE = 0
  DATE_TYPE_ARRIVAL = 1

  SEARCH_MODE_NORMAL = 'N'
  SEARCH_MODE_ECONOMIC = 'P'

  constructor: (from, to) ->
    super()

    connection = root.element('ConReq')

    @addStart(connection, from)
    @addDestination(connection, to)
    @addTime(connection)
    @addFlags(connection)

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