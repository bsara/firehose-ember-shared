merge = (firehoseClassName, emberClass) ->
  firehoseClass = Firehose[firehoseClassName]
  
  Firehose.Object.prototype.set = Ember.Object.prototype.set
  Firehose.Object.prototype.get = Ember.Object.prototype.get
  
  if firehoseClass.__super__.constructor == Firehose.Object
    combinedClass = Ember.Object.extend firehoseClass.prototype
  else
    parentClassName = firehoseClass.__super__.constructor.name
    combinedClass = Firehose[parentClassName].extend firehoseClass.prototype
  
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
    