App.FocusTextFieldComponent = Ember.TextField.extend

  becomeFocused: (->
    this.$().focus()
  ).on 'didInsertElement'