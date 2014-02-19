App.FocusTextareaComponent = Ember.TextArea.extend

  becomeFocused: (->
    this.$().focus()
  ).on 'didInsertElement'