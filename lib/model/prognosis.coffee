Util = require './../util'

class Prognosis
  constructor: (rawJson, date) ->
    @platform = rawJson.Platform.Text
    @handicapped = rawJson.handicappedAccess is 1
    @status = rawJson.Status

    if rawJson.Time?
      @time = Util.parseOffsetTime rawJson.Time, date

    if rawJson.Capacity1st?
      @capacityFirst = rawJson.Capacity1st
    if rawJson.Capacity2nd?
      @capacitySecond = rawJson.Capacity2nd

module.exports = Prognosis