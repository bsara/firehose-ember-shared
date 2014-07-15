window.Generator =

  # http://stackoverflow.com/questions/105034/how-to-create-a-guid-uuid-in-javascript
  generateUUID: ->
    'xxxx-xxxx-xxxx-xxxx-xxxx-xxxx-xxxx-xxxx'.replace /x/g, (c) ->
      r = Math.random() * 16 | 0
      r.toString 16