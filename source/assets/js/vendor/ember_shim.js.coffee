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

  sortOn: (property, direction = "asc") ->
    this.set '_sortOn', property
    this.set '_sortDirection', direction
    
  sortObjects: ->
    return unless this.get('_sortOn')?
    this.sortBy this.get('_sortOn')
    this.reverse() if this.get('_sortDirection') == 'desc'
    
  _toArchivableJSON: ->
    archiveArray = []
    this.forEach (obj) ->
      archiveArray.push obj._toArchivableJSON()
    archiveArray
    
    

merge = (firehoseClassName, emberClass) ->
  firehoseClass = Firehose[firehoseClassName]
  
  return if firehoseClass.extend?
  
  Firehose.Object.prototype.set = emberClass.prototype.set
  Firehose.Object.prototype.get = emberClass.prototype.get
  
  if firehoseClass.__super__.constructor == Firehose.Object
    combinedClass = emberClass.extend firehoseClass.prototype
  else
    parentClassName = firehoseClass.__super__.constructor._firehoseType
    parentClass = Firehose[parentClassName]
    unless parentClass.extend?
      merge parentClassName, emberClass
    parentClass = Firehose[parentClassName]
    combinedClass = parentClass.extend firehoseClass.prototype
  
  $.extend combinedClass, firehoseClass
  
  combinedClass.prototype.init = firehoseClass
  
  Firehose[firehoseClassName] = combinedClass

Firehose.UniqueArray = EmberUniqueArray
  
$.extend Ember.CoreObject.prototype, Firehose.Object.prototype
$.extend Ember.CoreObject, Firehose.Object


for key, klass of Firehose
  if klass.prototype instanceof Firehose.Object
    merge key, Ember.Object