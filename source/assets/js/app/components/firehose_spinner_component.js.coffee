App.FirehoseSpinnerComponent = Ember.Component.extend

  classNames: 'spinner'
    
  spinner: null
  
  length  : 8       # The length of each line
  width   : 4       # The line thickness
  radius  : 8       # The radius of the inner circle
  color   : '#FFF'  # #rgb or #rrggbb or array of colors

  showSpinner: (->
    @spinner = new Spinner
      length   : this.get 'length'
      width    : this.get 'width'
      radius   : this.get 'radius'
      color    : this.get 'color'
    @spinner.spin @get('element')
  ).on 'didInsertElement'
  
  teardown: (->
    @spinner.stop()
  ).on 'willDestroyElement'
    
Ember.Handlebars.helper 'firehose-spinner', App.FirehoseSpinnerComponent
