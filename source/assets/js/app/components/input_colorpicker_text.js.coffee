App.InputColorpickerTextComponent = Ember.TextField.extend
  attributes: [
    "isPickerFlat",         # (boolean) <TODO: Add description>. Default: true
    "usePickerLivePreview", # (boolean) <TODO: Add description>. Default: true
    "showPickerEvent",      # (string) <TODO: Add description>. Default: 'click'

    "useAllCaps",           # (boolean) <TODO: Add description>. Default: true

    "pickerPosition",       # (enum) Determines where the color picker will appear relative to the input field.
                            #
                            #        Options:
                            #           'top'         # The picker's bottom left corner will touch the input field's top left corner.
                            #           'top-left'    # The picker's bottom right corner will touch the input field's top right corner.
                            #
                            #           'bottom'      # The picker's top left corner will touch the input field's bottom left corner.
                            #           'bottom-left' # The picker's top right corner will touch the input field's bottom right corner.
                            #
                            #           'left'        # The picker's right side will touch the input field's left side and be centered with the input field.
                            #           'left-high'   # The picker's bottom right corner will touch the input field's bottom left corner.
                            #           'left-low'    # The picker's top right corner will touch the input field's top left corner.
                            #
                            #           'right'       # The picker's left side will touch the input field's right side and be centered with the input field.
                            #           'right-high'  # The picker's bottom left corner will touch the input field's bottom right corner.
                            #           'right-low'   # The picker's top left corner will touch the input field's top right corner.
                            #
                            #        Default:
                            #           'bottom'

    "pickerValueSelector",  # (jQuery Selector) <TODO: Add description>. Default: this
    "pickerStyleSelector",  # (jQuery Selector) <TODO: Add description>. Default: null
    "pickerStyleAttribute", # (string) <TODO: Add description>. Default: 'color'

    "setColorEvent"        # (enum) Options: 'change', 'submit', 'hide'. Default: 'change'
  ]

  attributeBindings: [
    "onBeforeShowPickerAction", # (action) <TODO: Add description>. Default: null
    "onShowPickerAction",       # (action) <TODO: Add description>. Default: null
    "onChangePickerAction",     # (action) <TODO: Add description>. Default: null
    "onSubmitPickerAction",     # (action) <TODO: Add description>. Default: null
    "onHidePickerAction"        # (action) <TODO: Add description>. Default: null
  ]

  events: [
    "onBeforeShowPicker", # (function name) <TODO: Add description>. If not explicitly set, a default function will be used.
    "onShowPicker",       # (function name) <TODO: Add description>. If not explicitly set, a default function will be used.
    "onChangePicker",     # (function name) <TODO: Add description>. If not explicitly set, a default function will be used.
    "onSubmitPicker",     # (function name) <TODO: Add description>. If not explicitly set, a default function will be used.
    "onHidePicker"        # (function name) <TODO: Add description>. If not explicitly set, a default function will be used.
  ]



  didInsertElement: ->
    emberObject = this
    options     = {}

    @useAllCaps = true if @useAllCaps == undefined || typeof @useAllCaps != "boolean"

    @pickerPosition = "bottom" if !@pickerPosition? || [ "top", "top-left", "bottom", "bottom-left", "left", "left-high", "left-low", "right", "right-high", "right-low" ].indexOf(@pickerPosition) < 0

    @pickerValueSelector  = this     if !@pickerValueSelector?
    @pickerStyleSelector  = null     if !@pickerStyleSelector?
    @pickerStyleAttribute = "color"  if !@pickerStyleAttribute?

    @setColorEvent = "change" if !@setColorEvent? || [ "change", "submit", "hide" ].indexOf(@setColorEvent) < 0

    options.flat         = @isPickerFlat         if @isPickerFlat != undefined
    options.livePreview  = @usePickerLivePreview if @usePickerLivePreview != undefined
    options.eventName    = @showPickerEvent      if @showPickerEvent != undefined


    if !@onBeforeShowPicker?
      options.onBeforeShow = ->
        $(this).ColorPickerSetColor(@value)
        emberObject.sendAction "onBeforeShowPickerAction" if emberObject.onBeforeShowPickerAction?
    else
      options.onBeforeShow = emberObject.onBeforeShowPicker


    if !@onShowPicker?
      options.onShow = (colorPicker) ->
        emberObject.sendAction "onShowPickerAction" if emberObject.onShowPickerAction?
    else
      options.onShow = emberObject.onShowPicker


    if !@onChangePicker?
      options.onChange = (hsb, hex, rgb) ->
        emberObject.updateColors(hex) if !emberObject.setColorEvent? || emberObject.setColorEvent == "change"
        emberObject.sendAction "onChangePickerAction" if emberObject.onChangePickerAction?
    else
      options.onChange = emberObject.onChangePicker


    if !@onSubmitPicker?
      options.onSubmit = (hsb, hex, rgb, element) ->
        emberObject.updateColors(hex) if emberObject.setColorEvent == "submit"
        emberObject.sendAction "onSubmitPickerAction" if emberObject.onSubmitPickerAction?
        $(element).ColorPickerHide()
    else
      options.onSubmit = emberObject.onSubmitPicker


    if !@onHidePicker?
      options.onHide = (colorPicker) ->
        emberObject.updateColors(hex) if emberObject.setColorEvent == "hide"
        emberObject.sendAction "onHidePickerAction" if emberObject.onHidePickerAction?
    else
      options.onHide = emberObject.onHidePikcer


    this.$().ColorPicker(options)


  updateColors: (hex) ->
    emberObject = this
    hexString   = String(hex)

    if hexString.indexOf("#") < 0
      hexString = "#" + hexString
    if @useAllCaps == true
      hexString = hexString.toUpperCase()

    $(@pickerValueSelector)?.each ->
      if this instanceof Ember.Object
        this.set("value", hexString)
      else
        $(this).attr("value", hexString)

    if @pickerStyleSelector?
      $(@pickerStyleSelector)?.each(-> this.$().css(emberObject.pickerStyleAttribute, hexString))