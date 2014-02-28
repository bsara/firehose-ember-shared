Ember.Handlebars.registerHelper "ifeq", (param1, param2, options) ->
  param1 = Ember.Handlebars.get(this, param1, options);
  param2 = Ember.Handlebars.get(this, param2, options);
  return param1 == param2

Ember.Handlebars.registerHelper "ifneq", (param1, param2, options) ->
  param1 = Ember.Handlebars.get(this, param1, options);
  param2 = Ember.Handlebars.get(this, param2, options);
  return param1 != param2

Ember.Handlebars.registerHelper "ifgt", (param1, param2, options) ->
  param1 = Ember.Handlebars.get(this, param1, options);
  param2 = Ember.Handlebars.get(this, param2, options);
  return param1 > param2

Ember.Handlebars.registerHelper "ifgte", (param1, param2, options) ->
  param1 = Ember.Handlebars.get(this, param1, options);
  param2 = Ember.Handlebars.get(this, param2, options);
  return param1 >= param2

Ember.Handlebars.registerHelper "iflt", (param1, param2, options) ->
  param1 = Ember.Handlebars.get(this, param1, options);
  param2 = Ember.Handlebars.get(this, param2, options);
  return param1 < param2

Ember.Handlebars.registerHelper "iflte", (param1, param2, options) ->
  param1 = Ember.Handlebars.get(this, param1, options);
  param2 = Ember.Handlebars.get(this, param2, options);
  return param1 <= param2

Ember.Handlebars.registerHelper "ifstartswith", (value, prefix, options) ->
  value = Ember.Handlebars.get(this, value, options);
  prefix = Ember.Handlebars.get(this, prefix, options);
  return String(value).indexOf(String(prefix)) == 0

Ember.Handlebars.registerHelper "unlesstartswith", (value, prefix, options) ->
  value = Ember.Handlebars.get(this, value, options);
  prefix = Ember.Handlebars.get(this, prefix, options);
  return String(value).indexOf(String(prefix)) != 0

Ember.Handlebars.registerHelper "ifendswith", (value, suffix, options) ->
  value = Ember.Handlebars.get(this, value, options);
  suffix = Ember.Handlebars.get(this, suffix, options);

  tempValue = String(value)
  tempSuffix = String(suffix)
  
  return tempValue.lastIndexOf(tempSuffix) == (tempValue.length - (tempValue.length + 1))

Ember.Handlebars.registerHelper "unlessendswith", (value, suffix, options) ->
  value = Ember.Handlebars.get(this, value, options);
  suffix = Ember.Handlebars.get(this, suffix, options);

  tempValue = String(value)
  tempSuffix = String(suffix)
  
  return tempValue.lastIndexOf(tempSuffix) != (tempValue.length - (tempValue.length + 1))