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