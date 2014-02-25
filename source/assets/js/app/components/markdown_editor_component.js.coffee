App.MarkdownEditorComponent = Ember.TextArea.extend

  strategies: 'cannedResponse'
  
  wrapsFileLinksInMarkdown: true
  
  
  # public
  
  attachFile: (file) ->
    this._uploadFile file
    
    
  
  # file attachments
  
  _setupAttachments: ->
    this.$().on 'dragenter', (e) =>
      e.stopPropagation()
      e.preventDefault()
      e.dataTransfer.dropEffect = 'copy'
      this._swapPlaceholderContent "Waiting for you to drop file"
      
    this.$().on 'dragleave', (e) =>
      e.stopPropagation()
      e.preventDefault()
      e.dataTransfer.dropEffect = 'copy'
      this._swapPlaceholderContent "", true
      
    this.$().on 'drop', (e) =>
      e.stopPropagation()
      e.preventDefault()
      file = e.dataTransfer.files[0]
      this._uploadFile file
      
  
  _uploadFile: (file) ->
    company = Firehose.Agent.loggedInAgent.currentCompany
    this._swapPlaceholderContent()
    outgoingAttachment = Firehose.OutgoingAttachment.outgoingAttachmentWithFile file, company
    outgoingAttachment.upload
      progress: (percent) =>
        this._swapPlaceholderContent "#{percent}%"
      success: (link) =>
        if @get('wrapsFileLinksInMarkdown')
          string = "![#{file.name}](#{link})"
        else
          string = link
        this._swapPlaceholderContent string, true
      error: (error) =>
        this._swapPlaceholderContent "", true
        alert "Failed to upload file: #{error}"

      
  _swapPlaceholderContent: (content = "", discardPlaceholder = false) ->
    text = this.get('value') || ""
    placeholderRegex = /\[Uploading…(.*?)\]/
    if text.match placeholderRegex
      unless discardPlaceholder
        newText = text.replace placeholderRegex, "[Uploading… (#{content})]"
      else
        newText = text.replace placeholderRegex, content
    else
      startPlaceholder = "[Uploading…#{content}]" 
      if text
        newText = "#{text}\n\n#{startPlaceholder}"
      else
        newText = startPlaceholder
    this.set 'value', newText

  
  
  # text complete
  
  _setupTextComplete: ->
    strategyNames = this.get('strategies').split ","
    this.$().textcomplete this._strategiesWithNames( strategyNames )
    
  
  _strategiesWithNames: (strategyNames) ->
    strategies = []
    for strategyName in strategyNames
      strategies.push this._stategyByName( strategyName )
    strategies
  
  
  _stategyByName: (strategyName) ->
    strategy =
      match: /(^|\s)\$(\w*)$/
      search: (term, callback) =>
        results = _.filter this.get('completions'), (cannedResponse) ->
          if cannedResponse.get('name').indexOf( term ) > -1 
            true 
          else 
            false
        callback results
      replace: (value) =>
        body = value.get 'text'
        "$1#{body}"
      template: (value) =>
        value.get 'name'  
    strategy
    
    
  # private
  
  _notifyController: ->
    this.sendAction 'becameActive', this
    
    
  _wasAddedToDOM: (->
    this._setupTextComplete() if this.get('completions')?
    this._setupAttachments()
    this._notifyController()
  ).on 'didInsertElement'

          