Util = require './../util'
Station = require './station'

class Stop extends Station
  constructor: (rawJson, date) ->
    super(rawJson.Station)

    if rawJson.Dep?.Time?
      @departure = Util.parseOffsetTime(rawJson.Dep.Time, date)
    if rawJson.Prognosis?.Dep?
      @depPrognosis = new Prognosis(rawJson.Prognosis.Dep, date)

    if rawJson.Arr?.Time?
      @arrival = Util.parseOffsetTime(rawJson.Arr.Time, date)
    if rawJson.Prognosis?.Arr?
      @arrPrognosis = new Prognosis(rawJson.Prognosis.Arr, date)

module.exports = Stop