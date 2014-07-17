App.InifiniteScrollingMixin = Ember.Mixin.create


  scrollableAreaSelector: null

  isListeningForScrolling: true

  _scrollFunction: null

  _hasScrolledDown: false


  didScrollToBottom: ->


  didScrollToTop: ->


  _didScroll: ->
    if this._isScrolledToBottom()
      this.didScrollToBottom()
    if this._isScrolledToTop()
      this.didScrollToTop()


  _isScrolledToBottom: ->
    return unless @isListeningForScrolling
    scr = this.$( @scrollableAreaSelector )
    outerHeight   = scr.outerHeight()
    scrollHeight  = scr.get(0).scrollHeight
    scrollTop     = scr.scrollTop()
    if (scrollTop + outerHeight) > (scrollHeight - 50)
      @isListeningForScrolling = false
      return true
    false


  _isScrolledToTop: ->
    scr = this.$( @scrollableAreaSelector )
    scrollTop = scr.scrollTop()
    if scrollTop < 50 and @_hasScrolledDown and @isListeningForScrolling
      @isListeningForScrolling = false
      return true
    else if scrollTop > 50
      @_hasScrolledDown = true
      @isListeningForScrolling = true
    false


  # hooks

  setupInfiniteScrolling: ->
    # we want to make sure 'this' inside `_didScroll` refers
    # to the IndexView, so we use jquery's `proxy` method to bind it
    @_scrollFunction = $.proxy( this._didScroll, this )
    this.$( @scrollableAreaSelector ).on 'scroll', @_scrollFunction


  destroyInfiniteScrolling: ->
    if @_scrollFunction?
      this.$( @scrollableAreaSelector ).off 'scroll', @_scrollFunction
      @_scrollFunction = null
