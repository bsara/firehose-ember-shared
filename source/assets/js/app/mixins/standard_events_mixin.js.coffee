App.StandardEventsMixin = Ember.Mixin.create


  click: ->
    if @get('clickAction')?.trim()
      @sendAction 'clickAction'