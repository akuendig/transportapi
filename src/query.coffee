request = require "request"
xmlbuilder = require "xmlbuilder"

module.exports = class Query
  isJson: false

  beginXml: ->
    @isJson = false

    return xmlbuilder
      .create()
      .begin "ReqC",
        version: "1.0"
        encoding: "utf-8"
      .attribute('lang', 'en')
      .attribute('prod', 'iPhone3.1')
      .attribute('ver', '2.3')
      .attribute('accessId', 'MJXZ841ZfsmqqmSymWhBPy5dMNoqoGsHInHbWJQ5PTUZOJ1rLTkn8vVZOZDFfSe')

  fetch: (cb) ->
    if @isJson
      @requestJson(cb, @request)
    else
      @requestXml(cb, @request.doc().toString())

  requestXml: (cb, xml) ->
    request
      method: 'POST'
      uri: 'http://fahrplan.sbb.ch/bin/extxml.exe'
      headers:
        'User-Agent': 'SBBMobile/4.2 CFNetwork/485.13.9 Darwin/11.0.0'
        'Accept': 'application/xml'
        'Content-Type': 'application/xml'
      body: xml
      ,
      cb

  requestJson: (cb, json) ->
    request
      method: 'POST'
      uri: 'http://fahrplan.sbb.ch/bin/query.exe/dny'
      headers:
        'User-Agent': 'SBBMobile/4.2 CFNetwork/485.13.9 Darwin/11.0.0'
        'Accept': 'application/json'
      json: json
      ,
      cb
