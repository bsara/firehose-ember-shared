App.ErrorNoticeComponent = Ember.Component.extend
  tagName: 'div'

  classNames: [ 'errorbox' ]

  classNameBindings: [ 'trigger::hidden' ]

  errors: []

  header: "Error Messages"

  trigger: false