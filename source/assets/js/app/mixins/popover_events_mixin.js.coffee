App.PopoverEventsMixin = Ember.Mixin.create

  actions:
    openPopover: (options) ->
      controller = this.controllerFor options.name
      controller.popoverOptions = options
      controller.set 'model', options.model
      this.render options.name,
        into:   'application'
        outlet: 'popover'
    
    closePopover: ->
      this.disconnectOutlet
        outlet:     'popover'
        parentView: 'application'
