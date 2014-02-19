App.ModalAnchorView = Ember.View.extend


  tagName: 'a'
  
  
  click: (event) ->
    options =
      name:   this.get 'name'
      model:  this.get 'model'
      size:   this.get 'sizeHash'
    this.get('controller').send 'openModal', options
    
    
  sizeHash: (->
    size  = @size || "0,0"
    parts = @size.split ","
    r =
      width: parseInt parts[0]
      height: parseInt parts[1]
  ).property('size')
  