App.NoticeListComponent = Ember.Component.extend
  tagName: 'div'

  attributeBindings: [ 'class' ]

  class: null

  classNameBindings: [ 'trigger::hidden' ]

  header: "Notices"

  notices: []

  trigger: false