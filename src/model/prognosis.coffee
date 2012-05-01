Util = require './../util'

module.exports = class Prognosis
  constructor: (rawJson, date) ->
    if rawJson.Time?
      @time = Util.parseOffsetTime rawJson.Time, date
    if rawJson.Status?
      @status = rawJson.Status
    if rawJson.Platform?
      @platform = rawJson.Platform.Text

    if rawJson.handicappedAccess?.Time?
      @handicapped = rawJson.handicappedAccess is 1

    if rawJson.Capacity1st?
      @capacityFirst = rawJson.Capacity1st
    if rawJson.Capacity2nd?
      @capacitySecond = rawJson.Capacity2nd
