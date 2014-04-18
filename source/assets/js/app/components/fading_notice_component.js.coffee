App.FadingNoticeComponent = Ember.Component.extend

  tagName: 'div'

  attributeBindings: [ 'class', 'style' ]

  class: null

  fadeOutDuration: 3000

  notice: null

  noticeTrigger: false

  style: 'display: none;'


  showNotice: (->
    noticeTrigger = @get 'noticeTrigger'
    if noticeTrigger
      element = $("##{@elementId}")
      element.show()
      element.fadeOut(@fadeOutDuration, (=>
        newNoticeTriggerValue = null
        noticeTriggerType = typeof noticeTrigger

        if noticeTriggerType == 'boolean'
          newNoticeTriggerValue = false
        else if triggerType == 'number'
          newNoticeTriggerValue = 0

        @set 'noticeTrigger', newNoticeTriggerValue
      ))
  ).observes('noticeTrigger')