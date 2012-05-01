
isArray = (o) ->
  Object.prototype.toString.call(o) is '[object Array]'

# format: 00d10:55:00
parseOffsetTime = (timeString, base = new Date()) ->
  time = new Date()
  day = timeString.substring 0, 2 #skip 'd'
  hour = timeString.substring 3, 5 #skip ':'
  min = timeString.substring 6, 8 #skip ':'
  sec = timeString.substring 9, 11

  time.setDate(Number(day) + time.getDate())
  time.setHours hour
  time.setMinutes min
  time.setSeconds sec

  return time

parseYmdDate = (dateString) ->
  year = dateString.substring 0, 4
  month = dateString.substring 4, 6
  day = dateString.substring 6, 8

  new Date year, month, day

module.exports.isArray = isArray
module.exports.parseOffsetTime = parseOffsetTime
module.exports.parseYmdDate = parseYmdDate