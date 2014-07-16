App.GoogleMapComponent = Ember.Component.extend App.StandardEventsMixin,

  tagName: 'div'

  attributes: [ 'disableDefaultUI', 'latitude', 'longitude', 'markerTitle', 'useMarker', 'zoom' ]


  didInsertElement: ->
    hasErrors = false

    if !@latitude? || isNaN(@latitude)
      hasErrors = true
      console.error "ERROR: GoogleMap Ember Component - latitude is a required attribute and must be a valid number!"
    if !@longitude? || isNaN(@longitude)
      hasErrors = true
      console.error "ERROR: GoogleMap Ember Component - longitude is a required attribute and must be a valid number!"
    if hasErrors
      throw "Invalid tag attributes found"

    mapOptions =
      zoom             : if @zoom? && !isNaN(@zoom) then Number(@zoom) else 8
      center           : new google.maps.LatLng(Number(@latitude), Number(@longitude))
      disableDefaultUI : @disableDefaultUI if @disableDefaultUI? && typeof @disableDefaultUI == 'boolean'

    map = new google.maps.Map(this.$()[0], mapOptions)

    if @useMarker == true
      new google.maps.Marker
        position : mapOptions.center
        map      : map
        title    : if @markerTitle? then @markerTitle else String.EMPTY