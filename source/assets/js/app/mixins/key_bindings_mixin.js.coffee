App.KeyBindingsMixin = Ember.Mixin.create

  _ESCAPE_CHAR                 : "\\"
  _ESCAPE_CHAR_ESCAPED         : "\\\\"

  _SEPARATORS:
    BINDINGS                   : "<<;>>"
    BINDINGS_ESCAPED           : "\\;"
    BINDINGS_ESCAPED_TEMP      : "<<E;>>"
    BINDINGS_UNPROCESSED       : ";"

    EQUALS                     : "<<:>>"
    EQUALS_ESCAPED             : "\\:"
    EQUALS_ESCAPED_TEMP        : "<<E:>>"
    EQUALS_UNPROCESSED         : ":"

    MULTIPLE_KEYS              : "<<|>>"
    MULTIPLE_KEYS_ESCAPED      : "\\|"
    MULTIPLE_KEYS_ESCAPED_TEMP : "<<E|>>"
    MULTIPLE_KEYS_UNPROCESSED  : "|"


  keyBindings: null


  _setupKeyBindingsMixin: (->
    bindings        = @get 'keyBindings'
    bindingsIsArray = (bindings instanceof Array)

    if bindings? && (bindingsIsArray || bindings.trim())
      if !bindingsIsArray
        bindings = @_processSpecialCharacters(bindings).trim()
        bindings = if bindings.contains(@_SEPARATORS.BINDINGS) then bindings.split(@_SEPARATORS.BINDINGS) else [ bindings ]

      bindingCount = 0
      for binding in bindings
        try
          @_bindKeys binding, bindingCount++
        catch error
          console.error error.stack

    return
  ).on('didInsertElement')


  _bindKeys: (binding, bindingCount) ->
    if !binding.contains(@_SEPARATORS.EQUALS)
      throw "Invalid format! Attribute `keyBindings` missing `#{@_SEPARATORS.EQUALS_UNPROCESSED}`. See https://github.com/mysterioustrousers/firehose-ember-shared/wiki/Mixin:-Key-Bindings#attributes for more information."


    bindingKeysAndAction = binding.split @_SEPARATORS.EQUALS
    keyStrokes      = bindingKeysAndAction[0].trim()
    actionName      = bindingKeysAndAction[1].trim()
    actionAttribute = "keyBinding_#{bindingCount}"

    this[actionAttribute] = actionName


    keyStrokes = keyStrokes.normalizeSpaces()

    keyStrokes = keyStrokes.replace RegExp("\\s#{@_SEPARATORS.MULTIPLE_KEYS.escapeRegex()}", 'gmi'), @_SEPARATORS.MULTIPLE_KEYS
    keyStrokes = keyStrokes.replace RegExp("#{@_SEPARATORS.MULTIPLE_KEYS.escapeRegex()}\\s", 'gmi'), @_SEPARATORS.MULTIPLE_KEYS

    keyStrokesArray = if keyStrokes.contains(@_SEPARATORS.MULTIPLE_KEYS) then keyStrokes.split(@_SEPARATORS.MULTIPLE_KEYS) else [ keyStrokes ]

    for keyStroke in keyStrokesArray
      this.$().mousetrapBind(keyStroke, (element, keyStroke) =>
        @sendAction actionAttribute
      )

    return


  _processSpecialCharacters: (bindings) ->
    if bindings.contains @_SEPARATORS.BINDINGS_ESCAPED
      bindings = bindings.replace RegExp(@_SEPARATORS.BINDINGS_ESCAPED.escapeRegex(), 'gmi'), @_SEPARATORS.BINDINGS_ESCAPED_TEMP

    if bindings.contains @_SEPARATORS.EQUALS_ESCAPED
      bindings = bindings.replace RegExp(@_SEPARATORS.EQUALS_ESCAPED.escapeRegex(), 'gmi'), @_SEPARATORS.EQUALS_ESCAPED_TEMP

    if bindings.contains @_SEPARATORS.MULTIPLE_KEYS_ESCAPED
      bindings = bindings.replace RegExp(@_SEPARATORS.MULTIPLE_KEYS_ESCAPED.escapeRegex(), 'gmi'), @_SEPARATORS.MULTIPLE_KEYS_ESCAPED_TEMP

    bindings = bindings.replace RegExp(@_SEPARATORS.BINDINGS_UNPROCESSED.escapeRegex(),      'gmi'), @_SEPARATORS.BINDINGS
    bindings = bindings.replace RegExp(@_SEPARATORS.EQUALS_UNPROCESSED.escapeRegex(),        'gmi'), @_SEPARATORS.EQUALS
    bindings = bindings.replace RegExp(@_SEPARATORS.MULTIPLE_KEYS_UNPROCESSED.escapeRegex(), 'gmi'), @_SEPARATORS.MULTIPLE_KEYS

    bindings = bindings.replace RegExp(@_SEPARATORS.BINDINGS_ESCAPED_TEMP.escapeRegex(),      'gmi'), @_SEPARATORS.BINDINGS_UNPROCESSED
    bindings = bindings.replace RegExp(@_SEPARATORS.EQUALS_ESCAPED_TEMP.escapeRegex(),        'gmi'), @_SEPARATORS.EQUALS_UNPROCESSED
    bindings = bindings.replace RegExp(@_SEPARATORS.MULTIPLE_KEYS_ESCAPED_TEMP.escapeRegex(), 'gmi'), @_SEPARATORS.MULTIPLE_KEYS_UNPROCESSED

    if bindings.contains(@_ESCAPE_CHAR_ESCAPED) then bindings.replace(RegExp(@_ESCAPE_CHAR_ESCAPED.escapeRegex(), 'gm'), @_ESCAPE_CHAR) else bindings


