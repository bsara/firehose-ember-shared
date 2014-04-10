# !!!!!!!!!!!!!!!!! DEPRICATED !!!!!!!!!!!!!!!!! #
# Use input_textarea_component.js.coffee instead #

App.FocusTextareaComponent = Ember.TextArea.extend

  becomeFocused: (->
    this.$().focus()
  ).on 'didInsertElement'