class NotificationCenter


  @shared: null

  _observations: null


  constructor: ->
    @_observations = []


  addObserver: (observer, notification, responder) ->
    this.removeObserver observer, notification
    @_observations.push
      observer:     observer
      notification: notification
      responder:    responder


  removeObserver: (observer, notification) ->
    for observation in @_observations.slice(0)
      if observation.observer == observer
        if not notification or observation.notification == notification
          idx = @_observations.indexOf observation
          @_observations.splice idx, 1


  postNotification: (notification, data) ->
    for observation in @_observations
      if observation.notification == notification
        observer = observation.observer
        responder = observation.responder
        observer.notifications[responder].call( observer, data )


window.NotificationCenter = NotificationCenter
window.NotificationCenter.shared = new NotificationCenter()