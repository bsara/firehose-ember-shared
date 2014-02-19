App.TagInputComponent = Ember.Component.extend


  inputSelector: '.js-tag-input'
  
  autocomplete: null
  
  currentTags: []


  _wasInserted: (->
    this._setup()
    @$().focus()
  ).on 'didInsertElement'
  
  
  _setup: ->
    @autocomplete = new AutoComplete @$().attr('id'), 
      initialValue: _.map _.filter(this.get('prepopulateWithTags'), (tag) -> tag.length > 0), (tag) -> [tag]
      placeholderHTML: this.get('placeholder') || "Tags"
      lists:
        tags:
          allowFreeform: true
          options: this.get('availableTags')
      onChange: (newValue, oldValue) =>
        current       = _.filter _.pluck(_.flatten(newValue), 'value'), (tag) -> tag.length > 0
        previous      = _.filter _.pluck(_.flatten(oldValue), 'value'), (tag) -> tag.length > 0
        removed       = _.difference previous, current
        added         = _.difference current, previous
        @currentTags  = current
        if added.length > 0
          this.sendAction 'tagWasAdded', added[0], this
        if removed.length > 0
          this.sendAction 'tagWasRemoved', removed[0], this
    