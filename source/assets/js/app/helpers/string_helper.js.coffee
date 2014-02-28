Ember.Handlebars.registerBoundHelper 'padLeft', (value, length, paddingCharacter) ->
  if !value? then throw "value cannot be null!"
  if !length? then throw "length cannot be null!"
  if !paddingCharacter? then throw "paddingCharacter cannot be null!"
  
  result = String(value)
  (result = paddingCharacter + result) while (result.length < length)
  result

Ember.Handlebars.registerBoundHelper 'concat', (value1, value2) ->
  if !value1? then throw "value1 cannot be null!"
  if !value2? then throw "value2 cannot be null!"
  
  String(value1) + String(value2)

Ember.Handlebars.registerBoundHelper 'startsWith', (value, prefix) ->
  if !value? then throw "value cannot be null!"
  if !prefix? then throw "prefix cannot be null!"
  
  String(stringToCheck).indexOf(String(prefix)) == 0

Ember.Handlebars.registerBoundHelper 'endsWith', (value, suffix) ->
  if !value? then throw "value cannot be null!"
  if !suffix? then throw "suffix cannot be null!"

  tempValue = String(value)
  tempSuffix = String(suffix)
  
  tempValue.lastIndexOf(tempSuffix) == (tempValue.length - (tempValue.length + 1))