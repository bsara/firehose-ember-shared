Ember.Handlebars.registerBoundHelper 'padLeft', (value, length, paddingCharacter) ->
  if !value? then throw "value cannot be null!"
  if !length? then throw "length cannot be null!"
  if !paddingCharacter? then throw "paddingCharacter cannot be null!"
  
  result = String(value)
  (result = paddingCharacter + result) while (result.length < length)
  result