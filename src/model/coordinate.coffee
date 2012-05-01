module.exports = class Coordinate
  constructor: (rawJson) ->
    @x = rawJson.x
    @y = rawJson.y
    @type = rawJson.type
