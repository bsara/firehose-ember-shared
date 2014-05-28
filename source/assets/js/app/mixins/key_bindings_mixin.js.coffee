App.KeyBindingsMixin = Ember.Mixin.create

  _ESCAPE_CHAR         = "\\"
  _ESCAPE_CHAR_ESCAPED = "\\\\"

  _SEPARATORS:
    BINDINGS                : ";"
    BINDINGS_ESCAPED        : "#{@_ESCAPE_CHAR};"
    BINDINGS_TEMP           : "[<<****TEMP-BINDINGS****>>]"

    EQUALS                  : ":"
    EQUALS_ESCAPED          : "#{@_ESCAPE_CHAR}:"
    EQUALS_TEMP             : "[<<****TEMP-EQUALS****>>]"

    GROUP_START             : "("
    GROUP_START_ESCAPED     : "#{@_ESCAPE_CHAR}("
    GROUP_START_TEMP        : "[<<****TEMP-GROUP-START****>>]"

    GROUP_END               : ")"
    GROUP_END_ESCAPED       : "#{@_ESCAPE_CHAR})"
    GROUP_END_TEMP          : "[<<****TEMP-GROUP-END****>>]"

    MULTIPLE_KEYS           : "|"
    MULTIPLE_KEYS_ESCAPED   : "#{@_ESCAPE_CHAR}|"
    MULTIPLE_KEYS_TEMP      : "[<<****TEMP-MULTIPLE-KEYS****>>]"

    SEQUENTIAL_KEYS         : " "
    SEQUENTIAL_KEYS_ESCAPED : "#{@_ESCAPE_CHAR}s"
    SEQUENTIAL_KEYS_TEMP    : "[<<****TEMP-SEQUENTIAL-KEYS****>>]"


  keyBindings: null


  _bindKeys: (->
    bindings        = @get 'keyBindings'
    bindingsIsArray = (bindings instanceof Array)

    if bindings? && (bindingsIsArray || bindings.trim())
      hasReplacedEscapedEscapeChars = false
      hasTempBindingSeparatorString = false

      if !bindingsIsArray
        @_replaceEscapedEscapeChars bindings
        hasReplacedEscapedEscapeChars = true

        if bindings.contains @_SEPARATORS.BINDINGS_ESCAPED
          bindings = bindings.replace RegExp(@_SEPARATORS.BINDINGS_ESCAPED.escapeRegex()), 'gm'), @_SEPARATORS.BINDINGS_TEMP
          hasTempBindingSeparatorString = true
        bindings = if bindings.contains(@_SEPARATORS.BINDINGS) then bindings.split(@_SEPARATORS.BINDINGS) else [ bindings ]

      for binding in bindings
        try
          @_processBinding binding, hasReplacedEscapedEscapeChars, hasTempBindingSeparatorString
        catch error
          console.error error

    return
  ).on('didInsertElement')


  _processBinding: (binding, hasReplacedEscapedEscapeChars, hasTempBindingSeparatorString) ->
    hasTempEqualsString         = false


    if !hasReplacedEscapedEscapeChars
      @_replaceEscapedEscapeChars(bindings)

    if hasTempBindingSeparatorString
      binding = binding.replace RegExp(@_SEPARATORS.BINDINGS_TEMP.escapeRegex(), 'gm'), @_SEPARATORS.BINDINGS
    binding = binding.trim()


    if binding.contains @_SEPARATORS.EQUALS_ESCAPED
      binding = binding.replace RegExp(@_SEPARATORS.EQUALS_ESCAPED.escapeRegex(), 'gm'), @_SEPARATORS.EQUALS_TEMP
      hasTempEqualsString = true

    if !binding.contains(@_SEPARATORS.EQUALS)
      throw "Invalid format! Attribute `keyBindings` missing `#{@_SEPARATORS.EQUALS}`. See https://github.com/mysterioustrousers/firehose-ember-shared/wiki/Mixin:-Key-Bindings#attributes for more information."


    bindingKeysAndAction = binding.split @_SEPARATORS.EQUALS
    keys       = bindingKeysAndAction[0].trim()
    actionName = bindingKeysAndAction[1].trim()


    @_processKeys keys, hasTempEqualsString

    return


  _processKeys: (keys, hasTempEqualsString) ->
    hasTempGroupStartString     = false
    hasTempGroupEndString       = false
    hasTempMultipleKeysString   = false
    hasTempSequentialKeysString = false


    if keys.contains @_SEPARATORS.GROUP_START_ESCAPED
      keys = keys.replace RegExp(@_SEPARATORS.GROUP_START_ESCAPED.escapeRegex(), 'gm'), @_SEPARATORS.GROUP_START_TEMP
      hasTempGroupStartString = true

    if keys.contains @_SEPARATORS.GROUP_END_ESCAPED
      keys = keys.replace RegExp(@_SEPARATORS.GROUP_END_ESCAPED.escapeRegex(), 'gm'), @_SEPARATORS.GROUP_END_TEMP
      hasTempGroupEndString = true

    if keys.contains @_SEPARATORS.MULTIPLE_KEYS_ESCAPED
      keys = keys.replace RegExp(@_SEPARATORS.MULTIPLE_KEYS_ESCAPED.escapeRegex(), 'gm'), @_SEPARATORS.MULTIPLE_KEYS_TEMP
      hasTempMultipleKeysString = true

    if keys.contains @_SEPARATORS.SEQUENTIAL_KEYS_ESCAPED
      keys = keys.replace RegExp(@_SEPARATORS.SEQUENTIAL_KEYS_ESCAPED.escapeRegex(), 'gm'), @_SEPARATORS.SEQUENTIAL_KEYS_TEMP
      hasTempSequentialKeysString = true


    keys = keys.normalizeSpaces()
    keys = keys.replace(RegExp("#{@_SEPARATORS.GROUP_START.escapeRegex()}\s",   'gm'), @_SEPARATORS.GROUP_START)
    keys = keys.replace(RegExp("\s#{@_SEPARATORS.GROUP_END.escapeRegex()}",     'gm'), @_SEPARATORS.GROUP_END)
    keys = keys.replace(RegExp("\s#{@_SEPARATORS.MULTIPLE_KEYS.escapeRegex()}", 'gm'), @_SEPARATORS.MULTIPLE_KEYS)
    keys = keys.replace(RegExp("#{@_SEPARATORS.MULTIPLE_KEYS.escapeRegex()}\s", 'gm'), @_SEPARATORS.MULTIPLE_KEYS)


    # Groups

    if keys.contains @_SEPARATORS.GROUP_START
      invalidFormatErrorMessage = "Invalid Format! Attribute `keyBindings` doesn't have enough group endings (`#{@_SEPARATORS.GROUP_END}`). See https://github.com/mysterioustrousers/firehose-ember-shared/wiki/Mixin:-Key-Bindings#attributes for more information."

      if !keys.contains(@_SEPARATORS.GROUP_END) || keys.occurrences(@_SEPARATORS.GROUP_START) != keys.occurrences(@_SEPARATORS.GROUP_END)
        throw invalidFormatErrorMessage
    else if keys.contains @_SEPARATORS.GROUP_END
        throw "Invalid Format! Attribute `keyBindings` doesn't have enough group beginnings (`#{@_SEPARATORS.GROUP_START}`). See https://github.com/mysterioustrousers/firehose-ember-shared/wiki/Mixin:-Key-Bindings#attributes for more information."


  _replaceEscapedEscapeChars: (str) ->
    if str.contains(@_ESCAPE_CHAR_ESCAPED) then str.replace RegExp(@_ESCAPE_CHAR_ESCAPED.escapeRegex(), 'gm'), @_ESCAPE_CHAR else str
