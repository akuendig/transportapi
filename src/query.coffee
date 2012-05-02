xmlbuilder = require "xmlbuilder"

module.exports = class Query

  XML_URI: 'http://fahrplan.sbb.ch/bin/extxml.exe'
  JSON_URI: 'http://fahrplan.sbb.ch/bin/query.exe/dny'

  XML_HEADERS:
    'User-Agent': 'SBBMobile/4.2 CFNetwork/485.13.9 Darwin/11.0.0'
    'Accept': 'application/xml'
    'Content-Type': 'application/xml'

  JSON_HEADERS:
    'User-Agent': 'SBBMobile/4.2 CFNetwork/485.13.9 Darwin/11.0.0'
    'Accept': 'application/json'


  beginXml: ->
    return xmlbuilder
      .create()
      .begin "ReqC",
        version: "1.0"
        encoding: "utf-8"
      .attribute('lang', 'en')
      .attribute('prod', 'iPhone3.1')
      .attribute('ver', '2.3')
      .attribute('accessId', 'MJXZ841ZfsmqqmSymWhBPy5dMNoqoGsHInHbWJQ5PTUZOJ1rLTkn8vVZOZDFfSe')
