App.InputTextMixin = Ember.Mixin.create


  _focusOnLoad: (->
    focusOnLoad = @get 'focusOnLoad'
    if focusOnLoad?.trim() == "true"
      this.$().focus()
  ).on('didInsertElement')