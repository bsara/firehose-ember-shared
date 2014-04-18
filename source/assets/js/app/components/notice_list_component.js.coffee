App.NoticeListComponent = Ember.Component.extend
  tagName: 'div'

  attributeBindings: [ 'class' ]

  class: null

  classNameBindings: [ 'noticesTrigger::hidden' ]

  header: "Notices"

  notices: []

  noticesTrigger: false