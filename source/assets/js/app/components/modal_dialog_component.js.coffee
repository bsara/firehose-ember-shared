App.ModalDialogComponent = Ember.Component.extend 


  size: { width: 600, height: 600 }
  
  
  actions:
    close: ->
      this.sendAction()
      

  didInsertElement: ->
    options     = this.get 'options'
    $modal      = this.$ '.js-modal'
    $content    = this.$ '.js-content'
    
    sizeWidth   = if options.size then options.size.width else @size.width
    sizeHeight  = if options.size then options.size.height else @size.height
    
    top         = ($( document ).height() / 2) - (sizeHeight / 2)
    left        = ($( document ).width() / 2) - (sizeWidth / 2)
  
    $modal.css
      top:    top
      left:   left
      width:  sizeWidth
      
    if $content.height() > sizeHeight
      $content.height( sizeHeight - parseInt($content.css('margin')) * 2 )
      $modal.height sizeHeight
      
    $modal.find('input').first().focus()