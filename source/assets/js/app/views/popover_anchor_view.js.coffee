App.PopoverAnchorView = Ember.View.extend


  tagName: 'a'


  click: (event) ->
    # Eventually it would be better to replace this
    # with a better way of seeing if a child element
    # was the one that was clicked, but for now this
    # works
    if event.toElement.parentElement.tagName == "A"
      event.toElement.parentElement.click()
    else
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
