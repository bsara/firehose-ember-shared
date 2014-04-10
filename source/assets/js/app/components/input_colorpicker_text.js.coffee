App.InputColorpickerTextComponent = Ember.TextField.extend
  attributes: [
    "isPickerFlat",         # (boolean) Whether the color picker is appended to the element or triggered by an event. Default: false
    # "usePickerLivePreview", # (boolean) Whether the color values are filled in the fields while changing values on selector or a field. If false it may improve speed. Default: true
    "defaultColor",         # (string) The default color. String for hex color or hash for RGB and HSB ({r:255, r:0, b:0}). Default: 'ff0000'
    "showPickerEvent",      # (string) The desired event to trigger the colorpicker. Default: 'click'

    "useAllCaps",           # (boolean) When true, all capital letters are used for hex representations of colors. Default: true

    "pickerPosition",       # (enum) Determines where the color picker will appear relative to the input field.
                            #        If a value is given that is not listed below, then the default will be used.
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

    "pickerValueSelector",  # (jQuery Selector) Used to find all elements that should have their values updated when the color is updated. Default: this
    "pickerStyleSelector",  # (jQuery Selector) Used to find all elements that should have their CSS updated when the color is updated. Default: null
    "pickerStyleAttribute", # (string) The CSS attribute to update for the object(s) specified by 'pickerStyleSelector'. Default: 'color'
                            #          TODO: Add ability to specify multiple attributes

    "setColorEvent"         # (enum) The event on which the color should be set as the current color and the elements specified by 'pickerValueSelector' and
                            #        'pickerStyleSelector' should be updated accordingly. If a value is given that is not listed below, then the default will be used.
                            #
                            #        Options:
                            #          'change', 'submit', 'hide'
                            #
                            #        Default:
                            #          'change'
  ]

  attributeBindings: [
    "onBeforeShowPickerAction", # (ember.js action) Ember action to perform during 'onBeforeShowPicker'. Default: null
    "onShowPickerAction",       # (ember.js action) Ember action to perform during 'onShowPicker'. Default: null
    "onChangePickerAction",     # (ember.js action) Ember action to perform during 'onChangePicker'. Default: null
    "onSubmitPickerAction",     # (ember.js action) Ember action to perform during 'onSubmitPicker'. Default: null
    "onHidePickerAction"        # (ember.js action) Ember action to perform during 'onHidePicker'. Default: null
  ]

  events: [
    "onBeforeShowPicker", # (function) Callback function triggered before the color picker is shown. If not explicitly set, a default function will be used.
    "onShowPicker",       # (function) Callback function triggered when the color picker is shown. If not explicitly set, a default function will be used.
    "onChangePicker",     # (function) Callback function triggered when the color is changed. If not explicitly set, a default function will be used.
    "onSubmitPicker",     # (function) Callback function triggered when the color it is chosen. If not explicitly set, a default function will be used.
    "onHidePicker"        # (function) Callback function triggered when the color picker is hidden. If not explicitly set, a default function will be used.
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
    # options.livePreview  = @usePickerLivePreview if @usePickerLivePreview != undefined
    options.color        = @defaultColor         if @defaultColor != undefined
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