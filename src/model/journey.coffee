Stop = require './stop'

module.exports = class Journey
  constructor: (rawJson) ->
    if rawJson.JourneyAttributeList?.JourneyAttribute?
      for journey in rawJson.JourneyAttributeList.JourneyAttribute
        switch journey.Attribute.type
          when 'NAME'
            @name = journey.Attribute.AttributeVariant.Text
          when 'CATEGORY'
            journey.Attribute.AttributeVariant.forEach (el) =>
              @category = el.Text if el.type is 'NORMAL'
          when 'INTERNALCATEGORY'
            @subcategory = journey.Attribute.AttributeVariant.Text
          when 'NUMBER'
            @number = journey.Attribute.AttributeVariant.Text
          when 'OPERATOR'
            @operator = journey.Attribute.AttributeVariant.Text
          when 'DIRECTION'
            @to = journey.Attribute.AttributeVariant.Text

    if rawJson.PassList?.BasicStop?
      passList = rawJson.PassList.BasicStop

      if not Array.isArray passList
        passList = [passList]

      @passList = rawJson.PassList.BasicStop.map (stop) -> new Stop(stop)
