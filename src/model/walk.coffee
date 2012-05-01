Util = require './../util'

module.exports = class Walk
  constructor: (rawJson) ->
    time = Util.parseOffsetTime rawJson.Duration.Time
    @duration = time - Date.now
