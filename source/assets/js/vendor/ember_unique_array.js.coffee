window.EmberUniqueArray = Ember.ArrayProxy.extend
  
  
  _sortOn: null
  
  _sortDirection: 'asc'
  
  
  init: ->
    this.set "content", []
    this._super()
  
  push: ->
    this.addObject.apply this, arguments
    
  
  appendObject: ->
    this.addObject.apply this, arguments
  
  
  appendObjects: (objects) ->
    this.addObjects.apply this, arguments
    
    
  insertObject: ->
    this.appendObject.apply this, arguments
    this.sortObjects()
    
    
  insertObjects: (objects) -> 
    this.appendObjects objects
    this.sortObjects()
    
        
  dropObject: ->
    this.removeObject.apply this, arguments
      
      
  dropObjects: (objects) ->
    this.removeObjects.apply this, arguments


  sortOn: (property, direction) ->
    @_sortOn        = property
    @_sortDirection = direction || 'asc'


  sortObjects: ->
    return unless @_sortOn?
    this.sortBy @_sortOn
    this.reverse() if @_sortDirection == 'desc'
    
    
  # @nodoc
  _toArchivableJSON: ->
    archiveArray = []
    this.forEach (obj) ->
      archiveArray.push obj._toArchivableJSON()
    archiveArray