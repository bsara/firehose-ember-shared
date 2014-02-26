Ember.Handlebars.registerBoundHelper 'padLeft', (value, length, paddingCharacter) ->
  if !value? then throw "value cannot be null!"
  if !paddingCharacter? then throw "paddingCharacter cannot be null!"
  
  (value = paddingCharacter + value) while (value.length < length)
  value