asyncxml = require "asyncxml"

class Sbb
  queryConnection : (from, to, cb) ->
    xml = ""
    builder = new asyncxml.Builder
      pretty: true

    builder.on 'data', (data) -> xml += data
    builder.on 'end', (err) -> cb(err, xml)

    builder.tag "xml", version: "1.0", encoding: "utf-8"
      .tag("ReqC").up()

    builder.end()

module.exports = Sbb
