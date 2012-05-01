request = require "request"
xmlbuilder = require "xmlbuilder"

class Query

  constructor: ->
    @root =
      xmlbuilder
      .create()
      .begin "ReqC",
        version: "1.0"
        encoding: "utf-8"
      .attribute('lang', 'en')
      .attribute('prod', 'iPhone3.1')
      .attribute('ver', '2.3')
      .attribute('accessId', 'MJXZ841ZfsmqqmSymWhBPy5dMNoqoGsHInHbWJQ5PTUZOJ1rLTkn8vVZOZDFfSe')

  request: (cb) ->
    body = @root.doc().toString
      pretty: true
      indent: '  '

    request
      method: 'POST'
      uri: 'http://xmlfahrplan.sbb.ch/bin/extxml.exe/'
      headers:
        'User-Agent': 'SBBMobile/4.2 CFNetwork/485.13.9 Darwin/11.0.0'
        'Accept': 'application/xml'
        'Content-Type': 'application/xml'
      body: body
      ,
      cb

module.exports = Query
