App.ModalDialogComponent = Ember.Component.extend

  modal         : null

  content       : null

  gravity       : 'center'

  gravityPoints : { top: 0 }

  size          : { width: "600", height: "600" }


  actions:
    close: ->
      this.sendAction()


  didInsertElement: ->
    options       = this.get 'options'
    @modal        = this.$ '.js-modal'
    @content      = this.$ '.js-content'
    @gravity      = options.gravity if options.gravity?

    if options.gravityPoints?
      @gravityPoints.top = options.gravityPoints.top if options.gravityPoints.top

    if options.size?
      @size.width  = options.size.width  if options.size.width?
      @size.height = options.size.height if options.size.height?

    @_layout()

    $(window).on 'resize', $.proxy(@_layout, this)
    @modal.find('input').first().focus()
    Ember.run.schedule 'afterRender', =>
      $(window).resize()


  willDestroyElement: ->
    $(window).off 'resize', $.proxy(@_layout, this)


  _layout: ->
    widthString  = @size.width
    heightString = @size.height

    width = Number widthString.replace( /\D/g, "" )
    if widthString.match /%$/
      width = $(window).width() * ( width / 100.0)

    height = Number heightString.replace( /\D/g, "" )
    if heightString.match /%$/
      height = $(window).height() * ( height / 100.0 )

    margin = parseInt(@content.css('margin'))
    if @content.height() < height and heightString[0] == '<'
      height = @content.height() + margin * 2
    else
      @content.height(height - margin * 2)

    if @gravity == 'top'
      top = @gravityPoints.top
    else
      top  = ($( document ).height() / 2) - (height / 2)
    left = ($( document ).width() / 2) - (width / 2)

    @modal.css
      top    : top
      left   : left
      width  : width
      height : height
