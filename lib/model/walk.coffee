Util = require './../util'

class Walk
  constructor: (rawJson) ->
    time = Util.parseOffsetTime rawJson.Duration.Time
    @duration = time - Date.now

module.exports = Walk