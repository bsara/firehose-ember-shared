Ember.Handlebars.registerBoundHelper 'sinceString', (date) ->
  moment(date).fromNow()


Ember.Handlebars.registerBoundHelper 'fullDateString', (date) ->
  moment(date).format 'MMMM Do, YYYY · h:mma'


Ember.Handlebars.registerBoundHelper 'fullDayMonthYearString', (date) ->
  moment(date).format 'MMMM Do, YYYY'


Ember.Handlebars.registerBoundHelper 'simpleSinceString', (date) ->
  return "?" if !date?
  dateMoment = moment date
  nowMoment  = moment new Date()

  dayDifference = nowMoment.diff dateMoment, 'days'
  if dayDifference > 0
    return "#{dayDifference}d"

  hourDifference = nowMoment.diff dateMoment, 'hours'
  if hourDifference > 0
    return "#{hourDifference}h"

  minuteDifference = nowMoment.diff dateMoment, 'minutes'
  if minuteDifference > 0
    return "#{minuteDifference}m"

  secondDifference = nowMoment.diff dateMoment, 'seconds'
  if secondDifference > 0
    return "#{secondDifference}s"