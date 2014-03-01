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

Firehose.UniqueArray.prototype.appendObject = Firehose.UniqueArray.prototype.addObject
Firehose.UniqueArray.prototype.appendObjects = Firehose.UniqueArray.prototype.addObjects
Firehose.UniqueArray.prototype.dropObject = Firehose.UniqueArray.prototype.removeObject
Firehose.UniqueArray.prototype.dropObjects = Firehose.UniqueArray.prototype.removeObjects
  
$.extend Ember.CoreObject.prototype, Firehose.Object.prototype
$.extend Ember.CoreObject, Firehose.Object


for key, klass of Firehose
  if klass.prototype instanceof Firehose.Object
    merge key, Ember.Object