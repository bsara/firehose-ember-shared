App.LoadingButtonComponent = Ember.Component.extend


  attributeBindings: ['disabled', 'title']

  tagName: 'button'

  isLoading: false
  
  buttonText: "Save"
  
  loadingText: "Saving…"
  
  
  click: (e) ->
    e.preventDefault()
    e.stopPropagation()
    if !this.get('isLoading')
      this.set 'isLoading', true
      this.sendAction 'action', =>
        this.set 'isLoading', false
        
    
  disabledChanged: (->
    if this.get 'disabled'
      @$().attr 'disabled', 'disabled'
    else
      @$().removeAttr 'disabled'
  ).observes 'disabled'