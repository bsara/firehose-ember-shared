App.InputColorpickerTextComponent = Ember.TextField.extend

  attributes: [
    'allCaps'        # (boolean) When `true`, all capital letters are used for hex representations of colors. Default: `true`
    'defaultColor'   # (string) The default color. String for hex color or hash for RGB and HSB ({r:255, r:0, b:0}). Default: `"FF0000"`
    'hideButtons'    # (boolean) When `true`, the cancel and submit buttons will not be available on the color picker. Default: `false`
    'livePreview'    # (boolean) Whether the color values are filled in the fields while changing values on selector or a field. If false it may improve speed. Default: `true`

    'onBeforeCancel'           # (ember.js action) Ember action to perform during `onBeforeCancel`. Default: null
    'onBeforeShowPickerAction' # (ember.js action) Ember action to perform during `onBeforeShowPicker`. Default: null
    'onChangePickerAction'     # (ember.js action) Ember action to perform during `onChangePicker`. Default: null
    'onHidePickerAction'       # (ember.js action) Ember action to perform during `onHidePicker`. Default: null
    'onShowPickerAction'       # (ember.js action) Ember action to perform during `onShowPicker`. Default: null
    'onSubmitPickerAction'     # (ember.js action) Ember action to perform during `onSubmitPicker`. Default: null

    'pickerPosition' # (enum) Determines where the color picker will appear relative to the input field.
                     #        If a value is given that is not listed below, then the default will be used.
                     #
                     #        Options:
                     #           `top-left`     # The picker's bottom left corner will touch the input field's top left corner.
                     #           `top-right`    # The picker's bottom right corner will touch the input field's top right corner.
                     #
                     #           `bottom-left`  # The picker's top left corner will touch the input field's bottom left corner.
                     #           `bottom-right` # The picker's top right corner will touch the input field's bottom right corner.
                     #
                     #           `left`         # The picker's right side will touch the input field's left side and be centered with the input field.
                     #           `left-top`     # The picker's bottom right corner will touch the input field's bottom left corner.
                     #           `left-bottom`  # The picker's top right corner will touch the input field's top left corner.
                     #
                     #           `right`        # The picker's left side will touch the input field's right side and be centered with the input field.
                     #           `right-top`    # The picker's bottom left corner will touch the input field's bottom right corner.
                     #           `right-bottom` # The picker's top left corner will touch the input field's top right corner.
                     #
                     #        Default:
                     #           `bottom-left`
    'popup'          # (boolean) Whether the color picker is appended to the element or triggered by an event. Default: `false`
    'popupEvent'     # (string) The desired event to trigger the color picker (only used if `popup` is `false`. Default: `click`


    'setColorEvent'  # (enum) The event on which the color should be set as the current color and the elements specified by `valueSelector` and
                     #        `styleSelector` should be updated accordingly. If a value is given that is not listed below, then the default will be used.
                     #
                     #        Options:
                     #          `change`, `submit`, `hide`
                     #
                     #        Default:
                     #          `change`
    'styleAttribute' # (string) The CSS attribute to update for the object(s) specified by `styleSelector`. Default: `color`
                     #          TODO: Add ability to specify multiple attributes
    'styleSelector'  # (jQuery Selector) Used to find all elements that should have their CSS updated when the color is updated. Default: `null`
    'valueSelector'  # (jQuery Selector) Used to find all elements that should have their values updated when the color is updated. Default: `this`
  ]

  events: [
    'onBeforeCancel'     # (function) Callback function triggered before the color picker is cancelled. If not explicitly set, a default function will be used.
    'onBeforeShowPicker' # (function) Callback function triggered before the color picker is shown. If not explicitly set, a default function will be used.
    'onCancel'           # (function) Callback function triggered when the color picker cancel is clicked. If not explicity set, a default function will be used.
    'onChangePicker'     # (function) Callback function triggered when the color is changed. If not explicitly set, a default function will be used.
    'onHidePicker'       # (function) Callback function triggered when the color picker is hidden. If not explicitly set, a default function will be used.
    'onShowPicker'       # (function) Callback function triggered when the color picker is shown. If not explicitly set, a default function will be used.
    'onSubmitPicker'     # (function) Callback function triggered when the color it is chosen. If not explicitly set, a default function will be used.
  ]


  didInsertElement: ->
    emberObject = this
    options     = {}

    options.allCaps        = @allCaps        if @allCaps != undefined && typeof @allCaps == 'boolean'
    options.defaultColor   = @defaultColor   if @defaultColor != undefined
    options.hideButtons    = @hideButtons    if @hideButtons != undefined && typeof @hideButtons == 'boolean'
    options.livePreview    = @livePreview    if @livePreview != undefined && typeof @livePreview == 'boolean'
    options.pickerPosition = @pickerPosition if @pickerPosition != undefined
    options.popup          = @popup          if @popup != undefined && typeof @popup == 'boolean'
    options.popupEvent     = @popupEvent     if @popupEvent != undefined

    @setColorEvent = 'change' if !@setColorEvent? || [ 'change', 'submit', 'hide' ].indexOf(@setColorEvent) < 0

    @styleAttribute = 'color'  if !@styleAttribute?
    @styleSelector  = null     if !@styleSelector?
    @valueSelector  = this     if !@valueSelector?


    if !@onBeforeCancel?
      options.onBeforeCancel = ->
        if emberObject.onBeforeCancelAction?
          return emberObject.sendAction 'onBeforeCancelAction'
        else
          return true
    else
      options.onBeforeCancel = @onBeforeCancel


    if !@onBeforeShowPicker?
      options.onBeforeShow = ->
        $(this).PickAColorSetColor(@value)

        if emberObject.onBeforeShowPickerAction?
          return emberObject.sendAction 'onBeforeShowPickerAction'
        else
          return true
    else
      options.onBeforeShow = @onBeforeShowPicker


    if !@onCancel?
      options.onCancel = ->
        emberObject.sendAction 'onCancelAction' if emberObject.onCancelAction?
    else
      options.onCancel = @onCancel


    if !@onChangePicker?
      options.onChange = (hsb, hex, rgb) ->
        emberObject.updateColors(hex) if !emberObject.setColorEvent? || emberObject.setColorEvent == 'change'
        emberObject.sendAction 'onChangePickerAction' if emberObject.onChangePickerAction?
    else
      options.onChange = @onChangePicker


    if !@onHidePicker?
      options.onHide = (colorPicker) ->
        emberObject.updateColors(hex) if emberObject.setColorEvent == 'hide'
        emberObject.sendAction 'onHidePickerAction' if emberObject.onHidePickerAction?
    else
      options.onHide = @onHidePicker


    if !@onShowPicker?
      options.onShow = (colorPicker) ->
        emberObject.sendAction 'onShowPickerAction' if emberObject.onShowPickerAction?
    else
      options.onShow = @onShowPicker


    if !@onSubmitPicker?
      options.onSubmit = (hsb, hex, rgb, element) ->
        emberObject.updateColors(hex) if emberObject.setColorEvent == 'submit'
        emberObject.sendAction 'onSubmitPickerAction' if emberObject.onSubmitPickerAction?
        $(element).PickAColorHide()
    else
      options.onSubmit = @onSubmitPicker


    this.$().PickAColor(options)


  updateColors: (hex) ->
    emberObject = this
    hexString   = String(hex)

    if hexString.indexOf("#") < 0
      hexString = "#" + hexString
    if @allCaps == true
      hexString = hexString.toUpperCase()

    $(@valueSelector)?.each ->
      if this instanceof Ember.Object
        this.set('value', hexString)
      else
        $(this).attr('value', hexString)

    if @styleSelector?
      $(@styleSelector)?.each(-> this.$().css(emberObject.styleAttribute, hexString))