Stop = require './stop'
Util = require './../util'

class Journey
  constructor: (rawJson) ->
    if rawJson.JourneyAttributeList?.JourneyAttribute?
      for journey in rawJson.JourneyAttributeList.JourneyAttribute
        switch journey.type
          when 'NAME'
            @name = journey.Attribute.AttributeVariant.Text
          when 'CATEGORY'
            @category
          when 'INTERNALCATEGORY'
            @subcategory
          when 'NUMBER'
            @number
          when 'OPERATOR'
            @operator
          when 'DIRECTION'
            @to

    if rawJson.PassList?.BasicStop?
      passList = rawJson.PassList.BasicStop

      if not Util.isArray passList
        passList = [passList]

      @passList = rawJson.PassList.BasicStop.map (stop) -> new Stop(stop)

module.exports = Journey
