# !!!!!!!!!!!!!!! DEPRICATED !!!!!!!!!!!!!!! #
# Use input_text_component.js.coffee isntead #

App.FocusTextFieldComponent = Ember.TextField.extend
  becomeFocused: (->
    this.$().focus()
  ).on 'didInsertElement'