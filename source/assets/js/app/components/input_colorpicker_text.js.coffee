App.InputColorpickerTextComponent = Ember.TextField.extend
  attributes: [
    "isPickerFlat",         # (boolean) <TODO: Add description>. Default = true
    "usePickerLivePreview", # (boolean) <TODO: Add description>. Default = true
    "showPickerEvent",      # (string) <TODO: Add description>. Default = 'click'

    "useAllCaps",           # (boolean) <TODO: Add description>. Default = true

    "pickerValueSelector",  # (jQuery Selector) <TODO: Add description>. Default = this
    "pickerStyleSelector",  # (jQuery Selector) <TODO: Add description>. Default = this
    "pickerStyleAttribute", # (string) <TODO: Add description>. Default = 'color'

    "setColorEvent"         # (enum) Options: 'change', 'submit', 'hide'. Default = 'change'
  ]

  attributeBindings: [
    "onBeforeShowPickerAction", # (action) <TODO: Add description>. Default = null
    "onShowPickerAction",       # (action) <TODO: Add description>. Default = null
    "onChangePickerAction",     # (action) <TODO: Add description>. Default = null
    "onSubmitPickerAction",     # (action) <TODO: Add description>. Default = null
    "onHidePickerAction"        # (action) <TODO: Add description>. Default = null
  ]

  events: [
    "onBeforeShowPicker", # (function name) <TODO: Add description>. Default = 'defaultOnBeforeShowPicker'
    "onShowPicker",       # (function name) <TODO: Add description>. Default = 'defaultOnShowPicker'
    "onChangePicker",     # (function name) <TODO: Add description>. Default = 'defaultOnChangePicker'
    "onSubmitPicker",     # (function name) <TODO: Add description>. Default = 'defaultOnSubmitPicker'
    "onHidePicker"        # (function name) <TODO: Add description>. Default = 'defaultOnHidePicker'
  ]



  didInsertElement: ->
    options              = {}

    @useAllCaps          = true     if @useAllCaps == undefined || typeof @useAllCaps != "boolean"
    @setColorEvent       = "change" if @setColorEvent? || [ "change", "submit", "hide" ].indexOf(@setColorEvent) < 0

    options.flat         = @isPickerFlat         if @isPickerFlat != undefined
    options.livePreview  = @usePickerLivePreview if @usePickerLivePreview != undefined
    options.eventName    = @showPickerEvent      if @showPickerEvent != undefined

    options.onBeforeShow = if !@onBeforeShowPicker? then @defaultOnBeforeShowPicker else @onBeforeShowPicker
    options.onShow       = if !@onShowPicker?       then @defaultOnShowPicker       else @onShowPicker
    options.onChange     = if !@onChangePicker?     then @defaultOnChangePicker     else @onChangePicker
    options.onSubmit     = if !@onSubmitPicker?     then @defaultOnSubmitPicker     else @onSubmitPicker
    options.onHide       = if !@onHidePikcer?       then @defaultOnHidePicker       else @onHidePicker

    this.$().ColorPicker(options)


  defaultOnBeforeShowPicker: ->
    $(this).ColorPickerSetColor(@value)
    this.sendAction "onBeforeShowPickerAction" if @onBeforeShowPickerAction?


  defaultOnShowPicker: (colroPicker) ->
    this.sendAction "onShowPickerAction" if @onShowPickerAction?


  defaultOnChangePicker: (hsb, hex, rgb) ->
    @updateColors(hex) if !@setColorEvent? || @setColorEvent == "change"
    this.sendAction "onChangePickerAction" if @onChangePickerAction?


  defaultOnSubmitPicker: (hsb, hex, rgb, element) ->
    @updateColors(hex) if @setColorEvent == "submit"
    this.sendAction "onSubmitPickerAction" if @onSubmitPickerAction?


  defaultOnHidePicker: (colroPicker) ->
    @updateColors(hex) if @setColorEvent == "hide"
    this.sendAction "onHidePickerAction" if @onHidePickerAction?


  updateColors: (hex) ->
    hexString = String(hex)

    if hexString.indexOf("#") < 0
      hexString = "#" + hexString
    if @useAllCaps == true
      hexString = hexString.toUpperCase()

    $(@pickerValueSelector)[0].attr("value", hexString);
    $(@pickerStyleSelector)[0].css(@pickerStyleAttribute, hexString)