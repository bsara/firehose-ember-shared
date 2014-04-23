Ember.Handlebars.registerBoundHelper 'concat', (value1, value2) ->
  if !value1? then throw "value1 cannot be null!"
  if !value2? then throw "value2 cannot be null!"

  String(value1) + String(value2)


Ember.Handlebars.registerBoundHelper 'ends-with', (value, suffix) ->
  if !value? then throw "value cannot be null!"
  if !suffix? then throw "suffix cannot be null!"

  tempValue = String(value)
  tempSuffix = String(suffix)

  tempValue.lastIndexOf(tempSuffix) == (tempValue.length - (tempValue.length + 1))


Ember.Handlebars.registerBoundHelper 'pad-left', (value, length, paddingCharacter) ->
  if !value? then throw "value cannot be null!"
  if !length? then throw "length cannot be null!"
  if !paddingCharacter? then throw "paddingCharacter cannot be null!"

  result = String(value)
  (result = paddingCharacter + result) while (result.length < length)
  result


Ember.Handlebars.registerBoundHelper 'starts-with', (value, prefix) ->
  if !value? then throw "value cannot be null!"
  if !prefix? then throw "prefix cannot be null!"

  String(stringToCheck).indexOf(String(prefix)) == 0


# DEPRICATED - Use `ends-with` instead
Ember.Handlebars.registerBoundHelper 'endsWith', (value, suffix) ->
  console.warn "Ember Handlebars helper `endsWith` is depricated! Use `ends-with` instead."

  if !value? then throw "value cannot be null!"
  if !suffix? then throw "suffix cannot be null!"

  tempValue = String(value)
  tempSuffix = String(suffix)

  tempValue.lastIndexOf(tempSuffix) == (tempValue.length - (tempValue.length + 1))


# DEPRICATED - Use `pad-left` instead
Ember.Handlebars.registerBoundHelper 'padLeft', (value, length, paddingCharacter) ->
  console.warn "Ember Handlebars helper `padLeft` is depricated! Use `pad-left` instead."

  if !value? then throw "value cannot be null!"
  if !length? then throw "length cannot be null!"
  if !paddingCharacter? then throw "paddingCharacter cannot be null!"

  result = String(value)
  (result = paddingCharacter + result) while (result.length < length)
  result


# DEPRICATED - use `starts-with` instead
Ember.Handlebars.registerBoundHelper 'startsWith', (value, prefix) ->
  console.warn "Ember Handlebars helper `startsWith` is depricated! Use `starts-with` instead."

  if !value? then throw "value cannot be null!"
  if !prefix? then throw "prefix cannot be null!"

  String(stringToCheck).indexOf(String(prefix)) == 0