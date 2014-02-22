App.Pusher = Ember.Object.extend
  
  
  company: null
  
  pusher: null
  
  
  init: () ->
    @pusher = new Pusher Firehose.tokenFor('pusher'), encrypted: true
    
    @pusher.connection.bind 'error', (error) =>
      @pusher.connect()


  subscribeWithCompany: (company) ->
    @company = company
    
    if @pusher.connection.state == 'connected'
      this._connected()
    else
      @pusher.connection.bind 'connected', =>
        this._connected()
      @pusher.connect()
      

  _connected: ->
    this._subscribeToChannels()
    @pusher.bind_all (eventName, data) =>
      this._handleEvent eventName, data


  _subscribeToChannels: ->
    @pusher.subscribe "company_#{@company.token}"
    @pusher.subscribe "customer_#{@company.token}" 
    @pusher.subscribe "interaction_#{@company.token}"
    

  _handleEvent: (eventName, data) ->
    return if eventName.match(/^pusher:/) # ignore pusher internal events
    NotificationCenter.defaultCenter.postNotification eventName, data


App.firehosePusher = App.Pusher.create()