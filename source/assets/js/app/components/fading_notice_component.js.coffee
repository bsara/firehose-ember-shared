App.FadingNoticeComponent = Ember.Component.extend

  tagName: 'div'

  attributeBindings: [ 'class', 'style' ]

  class: null

  fadeOutDuration: 3000

  notice: null

  style: 'display: none;'

  trigger: false


  showNotice: (->
    if @get('trigger')
      element = $("##{@elementId}")
      element.show()
      element.fadeOut(@fadeOutDuration, (=> @set('trigger', false)))
  ).observes('trigger')