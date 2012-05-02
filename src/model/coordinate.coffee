module.exports = class Coordinate
  constructor: (rawJson) ->
    @x = rawJson.x
    @y = rawJson.y

    if rawJson.type?
      @type = rawJson.type
    if rawJson.name?
      @name = rawJson.name
