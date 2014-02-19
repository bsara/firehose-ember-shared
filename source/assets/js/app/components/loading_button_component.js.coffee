App.LoadingButtonComponent = Ember.Component.extend

  tagName: 'button'

  isLoading: false
  
  buttonText: "Save"
  
  loadingText: "Saving…"
  
  click: ->
    if !this.get('isLoading')
      this.set 'isLoading', true
      this.sendAction 'action', =>
        this.set 'isLoading', false
    
