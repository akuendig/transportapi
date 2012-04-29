Query = require "query"

class LocationQuery extends Query
  SBB_SEARCH = 1
  LOCATION_TYPES =
    all: 'ALLTYPE'
    station: 'ST'
    address: 'ADR'
    poi: 'POI'

  constructor: ->
    super()

  forStation: (name) ->
    @root
      .element('LocValReq')
        .attribute('id', 'from')
        .attribute('sMode', SBB_SEARCH)
        .element('ReqLoc')
          .attribute('match', name)
          .attribute('type', LOCATION_TYPES['all'])