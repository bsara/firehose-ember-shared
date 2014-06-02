App.LoadingButtonComponent = Ember.Component.extend
  tagName: "button"

  attributeBindings: [ "disabled", "title" ]

  buttonText: "Save"
  loadingText: "Saving…"

  isLoading: false


  click: (e) ->
    e.preventDefault()
    e.stopPropagation()
    if !@isLoading
      @set "isLoading", true
      @sendAction "action", =>
        @set "isLoading", false if !@isDestroyed


  disabledChanged: (->
    if @disabled
      this.$().attr "disabled", "disabled"
    else
      this.$().removeAttr "disabled"
  ).observes "disabled"