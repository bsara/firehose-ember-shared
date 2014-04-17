App.ErrorNoticeComponent = Ember.Component.extend
  tagName: 'div'

  classNames: [ 'errorbox' ]

  classNameBindings: [ 'trigger::hidden' ]

  errors: []

  message: "Default Message"

  trigger: false