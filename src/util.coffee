namespace = exports ? this

# format: 00d10:55:00
namespace.parseOffsetTime = (timeString, base = new Date()) ->
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

namespace.parseYmdDate = (dateString) ->
  year = dateString.substring 0, 4
  month = dateString.substring 4, 6
  day = dateString.substring 6, 8

  return new Date year, month, day

namespace.dateToHHmm = (date) ->
  return date.getHours() + ':' + date.getMinutes()

namespace.dateToYmd = (date) ->
  year = date.getFullYear().toString()

  month = date.getMonth().toString()
  month = '0' + month if month.length is 1

  day = date.getDate().toString()
  day = '0' + day if day.length is 1

  return year + month + day

namespace.deepExtend = (reciever, extenders...) ->
  return if not reciever?

  for other in extenders
    for own key, val of other
      if typeof val is 'object'
        reciever[key] ?= {}
        @deepExtend(reciever[key], val)
      else if not reciever[key]?
        reciever[key] = val

  return reciever
