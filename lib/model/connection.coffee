Walk = require './walk'
Stop = require './stop'
Section = require './Section'
Util = require './../util'

class Connection
  constructor: (rawJson) ->
    date = Util.parseYmdDate rawJson.Overview.Date
    @from = new Stop rawJson.Overview.Departure.BasicStop, date
    @to = new Stop rawJson.Overview.Arrival.BasicStop, date

    sections = rawJson.ConSectionList.ConSection
    if not Util.isArray sections
      sections = [sections]

    @sections = sections.map (section) -> new Section(section)

module.exports = Connection
