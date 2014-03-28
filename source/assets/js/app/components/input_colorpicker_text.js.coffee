App.InputColorpickerTextComponent = Ember.TextField.extend
  attributes: [ "eventName", "color", "flat", "livePreview" ]
  events: [ "onShow", "onBeforeShow", "onHide", "onChange", "onSubmit" ]

  didInsertElement: ->
    options = {}
    self = this

    @get("attributes").forEach (attr) ->
      if self[attr] != undefined
        options[attr] = self[attr]

    @get("events").forEach (event) ->
      callback = self[event]
      if callback
        options[event] = callback

    this.$().ColorPicker(options)