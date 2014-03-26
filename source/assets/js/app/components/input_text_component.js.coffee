App.InputTextComponent = Ember.TextField.extend
  becomeFocused: (->
    doFocus = @get "doFocus"
    if doFocus?.trim() == "true"
      this.$().focus()
  ).on("didInsertElement")


  click: ->
    if @get("clickAction")?.trim()
      @sendAction "clickAction"