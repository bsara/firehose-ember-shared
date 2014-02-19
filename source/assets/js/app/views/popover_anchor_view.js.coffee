App.PopoverAnchorView = Ember.View.extend


  tagName: 'a'
  
  
  click: (event) ->
    options =
      name:   this.get 'name'
      model:  this.get 'model'
      arrow:  this.get 'arrow'
      size:   this.get 'sizeHash'
      offset: this.get 'offsetHash'
      anchor: event.target
    this.get('controller').send 'openPopover', options
    
    
  sizeHash: (->
    size  = @size || "0,0"
    parts = @size.split ","
    r =
      width: parseInt parts[0]
      height: parseInt parts[1]
  ).property('size')
  
  
  offsetHash: (->
    offset = @offset || "0,0"
    parts = offset.split ","
    r =
      x: parseInt parts[0]
      y: parseInt parts[1]
  ).property('offset')