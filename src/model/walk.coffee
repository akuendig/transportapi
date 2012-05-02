Util = require './../util'

module.exports = class Walk
  constructor: (rawJson) ->
    today = new Date()
    today.setHours(0)
    today.setMinutes(0)
    today.setSeconds(0)
    today.setMilliseconds(0)

    time = Util.parseOffsetTime(rawJson.Duration.Time, today)
    @duration = time.toLocaleTimeString()