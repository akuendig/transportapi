asyncxml = require "asyncxml"

class Sbb
  queryConnection = (from, to) ->
    xml = new asyncxml.Builder
      pretty: true

    xml.on 'data', console.log

    xml.tag("xml", version: "1.0" encoding: "utf-8").up()
    xml.tag("ReqC").up()

    xml.end

