App.FadingNoticeComponent = Ember.Component.extend

  tagName: 'div'

  attributeBindings: [ 'class', 'style' ]

  class: null

  fadeOutDuration: 3000

  notice: null

  style: 'display: none;'

  trigger: false


  showNotice: (->
    trigger = @get 'trigger'
    if trigger
      element = $("##{@elementId}")
      element.show()
      element.fadeOut(@fadeOutDuration, (=>
        newTriggerValue = null
        triggerType = typeof trigger

        if triggerType == 'boolean'
          newTriggerValue = false
        else if triggerType == 'number'
          newTriggerValue = 0

        @set 'trigger', newTriggerValue
      ))
  ).observes('trigger')