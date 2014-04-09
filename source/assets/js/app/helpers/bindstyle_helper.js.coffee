# -------------------------------------------------------------------------------------------- #
# This code was translated to coffeescript from javascript found at the follwing URL:          #
# https://github.com/yderidde/bindstyle-ember-helper/blob/master/src/bindstyle-ember-helper.js #
# -------------------------------------------------------------------------------------------- #


Ember.Handlebars.registerHelper "bind-style", (options) ->
  attrs = options.hash

  Ember.assert "You must specify at least one hash argument to bind-style", !!Ember.keys(attrs).length

  view  = options.data.view
  ret   = []
  style = []
  self  = this

  # Generate a unique id for this element. This will be added as a
  # data attribute to the element so it can be looked up when
  # the bound property changes.
  dataId = ++Ember.uuid

  attrKeys = Ember.keys(attrs).filter (item, index, self) ->
    return ((item.indexOf("unit") == -1) && (item != "static"))

  # For each attribute passed, create an observer and emit the
  # current value of the property as an attribute.
  attrKeys.forEach((attr) ->
    property = attrs[attr]

    Ember.assert "You must provide a String for a bound attribute, not #{property}", (typeof property == "string")

    propertyUnit = (attrs["#{attr}-unit"] || attrs["unit"] || "")

    value = Em.get(self, property)

    Ember.assert "Attributes must be numbers, strings or booleans, not #{value}", (value == null || typeof value == "number" || typeof value == "string" || typeof value == "boolean")

    observer = ->
      result = Em.get(self, property)

      Ember.assert "Attributes must be numbers, strings or booleans, not #{result}", (result == null || typeof result == "number" || typeof result == "string" || typeof result == "boolean")

      element = view.$("[data-bindAttr-#{dataId}='#{dataId}']")

      # If we aren't able to find the element, it means the element
      # to which we were bound has been removed from the view.
      # In that case, we can assume the template has been re-rendered
      # and we need to clean up the observer.
      if Ember.isNone(element) || element.length == 0
        Ember.removeObserver(self, property, invoker)
        return

      currentValue = element.css(attr)

      if currentValue != result
        element.css(attr, (result + propertyUnit))


    invoker = -> Ember.run.once(observer)

    # Add an observer to the view for when the property changes.
    # When the observer fires, find the element using the
    # unique data id and update the attribute to the new value.
    Ember.addObserver self, property, invoker

    style.push("#{attr}:#{value}#{propertyUnit};" + (attrs["static"] || ""))
  , this)

  # Add the unique identifier
  ret.push('style="' + style.join(' ') + '" data-bindAttr-' + dataId + '="' + dataId + '"')
  return new Ember.Handlebars.SafeString(ret.join(' '))