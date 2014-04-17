App.Session ||= {}
App.Session.redirectToLogin = ->
  window.location = Firehose.baseURLFor('browser') + "/home/login?return_to_url=#{encodeURIComponent(window.location.href)}"