App.ModalEventsMixin = Ember.Mixin.create

  actions:
    openModal: (options) ->
      controller = this.controllerFor options.name
      controller.modalOptions = options
      controller.set 'model', options.model
      this.render options.name,
        into:   'application'
        outlet: 'modal'

    closeModal: ->
      this.disconnectOutlet
        outlet:     'modal'
        parentView: 'application'