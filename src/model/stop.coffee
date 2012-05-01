Util = require './../util'
Station = require './station'
Prognosis = require './prognosis'

module.exports = class Stop extends Station
  constructor: (rawJson, date) ->
    super(rawJson.Station)

    if rawJson.Dep?.Time?
      @depTime = Util.parseOffsetTime(rawJson.Dep.Time, date).toJSON()
    if typeof rawJson.Dep?.Platform?.Text is 'string'
      @depPlatform = rawJson.Dep.Platform.Text
    if rawJson.StopPrognosis?.Dep?.Time? or
        rawJson.StopPrognosis?.Dep?.Status? or
        rawJson.StopPrognosis?.Dep?.Platform?
      @depPrognosis = new Prognosis(rawJson.StopPrognosis.Dep, date)

    if rawJson.Arr?.Time?
      @arrTime = Util.parseOffsetTime(rawJson.Arr.Time, date).toJSON()
    if typeof rawJson.Arr?.Platform?.Text is 'string'
      @arrPlatform = rawJson.Arr.Platform.Text
    if rawJson.StopPrognosis?.Arr.Time? or
        rawJson.StopPrognosis?.Arr?.Status? or
        rawJson.StopPrognosis?.Arr?.Platform?
      @arrPrognosis = new Prognosis(rawJson.StopPrognosis.Arr, date)
