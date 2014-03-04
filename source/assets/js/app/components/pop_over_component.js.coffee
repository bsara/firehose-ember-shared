# It's called PopOver instead of Popover because of the naming requirement: http://emberjs.com/guides/components/defining-a-component/

###
Options:
  anchor: The DOM element that the popover should "pop from"
  offset: The x,y offset the popover should appear relative to the anchor.
  size: The size of the popover.
  arrow: What side the arrow should appear on ('right' or 'left')
###
App.PopOverComponent = Ember.Component.extend


  size: { width: 300, height: 300 }
  
  popover: null
  
  content: null
  
  options: null
  
  
  actions:
    close: ->
      this.sendAction()
      

  didInsertElement: ->
    @set 'options', this.get 'options'
    @set 'popover', this.$ '.js-popover'
    @set 'content', this.$ '.js-content'
    @_layout = $.proxy(@_layout, this)
    @_layout()
    $(window).on 'resize', @_layout
    @popover.find('input').first().focus()
    
    
  willDestroyElement: ->
    $(window).off 'resize', @_layout
    
    
  _layout: ->
    if @options.anchor?
      $anchor     = Ember.$ @options.anchor
      position    = $anchor.offset()
      
      pinOffsetX  = if @options.offset then @options.offset.x else 0
      pinOffsetY  = if @options.offset then @options.offset.y else 0
      sizeWidth   = if @options.size then @options.size.width else @size.width
      sizeHeight  = if @options.size then @options.size.height else @size.height
      
      height      = parseInt( $anchor.height(), 10 ) + 10
      left        = if @options.arrow == 'left' then 0 else sizeWidth - ($anchor.width() / 2)
    
      @popover.addClass @options.arrow if @options.arrow
      @popover.css
        top:    (position.top + height) + pinOffsetY
        left:   (position.left - left) + pinOffsetX
        width:  sizeWidth
        
      if @content.height() > sizeHeight
        @content.height sizeHeight
        @popover.height sizeHeight
    