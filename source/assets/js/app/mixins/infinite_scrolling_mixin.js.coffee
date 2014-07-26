App.InifiniteScrollingMixin = Ember.Mixin.create


  scrollableAreaSelector: null

  isListeningForScrolling: true

  _scrollFunction: null

  _hasScrolledDown: false


  didScrollToBottom: ->


  didScrollToTop: ->


  _didScroll: ->
    if @_isScrolledToBottom()
      @didScrollToBottom()
    if @_isScrolledToTop()
      @didScrollToTop()


  _isScrolledToBottom: ->
    return unless @isListeningForScrolling
    scr = $(@scrollableAreaSelector)
    outerHeight   = scr.outerHeight()
    scrollHeight  = scr.get(0).scrollHeight
    scrollTop     = scr.scrollTop()
    if (scrollTop + outerHeight) > (scrollHeight - 50)
      @isListeningForScrolling = false
      return true
    false


  _isScrolledToTop: ->
    scr = $(@scrollableAreaSelector)
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
    @_scrollFunction = () => @_didScroll()
    $(@scrollableAreaSelector).on 'scroll', @_scrollFunction


  destroyInfiniteScrolling: ->
    if @_scrollFunction?
      $(@scrollableAreaSelector).off 'scroll', @_scrollFunction
      @_scrollFunction = null
