Ember.Handlebars.registerBoundHelper 'sinceString', (date) ->
  moment(date).fromNow()

Ember.Handlebars.registerBoundHelper 'fullDateString', (date) ->
  moment(date).format 'MMMM Do, YYYY · h:mma'