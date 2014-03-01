App.FirehoseSpinnerComponent = Ember.Component.extend

  classNames: 'spinner'
    
  spinner: null
  
  # defaults
  width   : 3       # The line thickness
  height  : 25      # The length of each line
  color   : '#FFF'  # #rgb or #rrggbb or array of colors

  showSpinner: (->
    $this = @$()
    $this.html '<div class="progress-indicator"><p>Loading</p></div>'
    indicator = $this.find('.progress-indicator p')
    indicator.css 
      backgroundColor : @get('color')
      width           : @get('width')
      height          : @get('height')
    deg = 0
    @spinner = setInterval ->
      indicator.css 
        transform : "rotate(#{deg}deg)"
      deg = if deg > 360 then 0 else deg + 5
    , 10 
  ).on 'didInsertElement'
  
  teardown: (->
    clearInterval @spinner
  ).on 'willDestroyElement'
    
Ember.Handlebars.helper 'firehose-spinner', App.FirehoseSpinnerComponent
