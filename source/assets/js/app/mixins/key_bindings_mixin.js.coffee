###

TEST DATA
=========

(ctrl+b|commmand+b)+(a|z)|(tab w)

ctrl+b+a
ctrl+b+z
commmand+b+a
commmand+b+z
tab w



(ctrl+k|command+k)+shift+s

ctrl+k+shift+s
command+k+shift+s



ctrl+k|command+k

ctrl+k
command+k



ctrl+k w|command+k g

ctrl+k w
command+k g



(ctrl+k w|command+k g) l+m

ctrl+k w l+m
command+k g l+m



(ctrl|command)+s

ctrl+s
command+s

###


App.KeyBindingsMixin = Ember.Mixin.create

  _ESCAPE_CHAR                 : "\\"
  _ESCAPE_CHAR_ESCAPED         : "\\\\"

  _SEPARATORS:
    BINDINGS                   : "<<;>>"
    BINDINGS_ESCAPED           : "#{@_ESCAPE_CHAR};"
    BINDINGS_ESCAPED_TEMP      : "<<E;>>"
    BINDINGS_UNPROCESSED       : ";"

    COMBO                      : "<<+>>"
    COMBO_ESCAPED              : "#{@_ESCAPE_CHAR}+"
    COMBO_ESCAPED_TEMP         : "<<E+>>"
    COMBO_UNPROCESSED          : "+"

    EQUALS                     : "<<:>>"
    EQUALS_ESCAPED             : "#{@_ESCAPE_CHAR}:"
    EQUALS_ESCAPED_TEMP        : "<<E:>>"
    EQUALS_UNPROCESSED         : ":"

    GROUP_START                : "<<(>>"
    GROUP_START_ESCAPED        : "#{@_ESCAPE_CHAR}("
    GROUP_START_ESCAPED_TEMP   : "<<E(>>"
    GROUP_START_UNPROCESSED    : "("

    GROUP_END                  : "<<)>>"
    GROUP_END_ESCAPED          : "#{@_ESCAPE_CHAR})"
    GROUP_END_ESCAPED_TEMP     : "<<E)>>"
    GROUP_END_UNPROCESSED      : ")"

    MULTIPLE_KEYS              : "<<|>>"
    MULTIPLE_KEYS_ESCAPED      : "#{@_ESCAPE_CHAR}|"
    MULTIPLE_KEYS_ESCAPED_TEMP : "<<E|>>"
    MULTIPLE_KEYS_UNPROCESSED  : "|"


  keyBindings: null


  _bindKeys: (->
    bindings        = @get 'keyBindings'
    bindingsIsArray = (bindings instanceof Array)

    if bindings? && (bindingsIsArray || bindings.trim())
      hasReplacedEscapedEscapeChars = false

      if !bindingsIsArray
        @_replaceEscapedEscapeChars bindings

        bindings = @_processSpecialCharacters(bindings).trim()

        bindings = if bindings.contains(@_SEPARATORS.BINDINGS) then bindings.split(@_SEPARATORS.BINDINGS) else [ bindings ]

      for binding in bindings
        try
          @_processBinding binding
        catch error
          if !(error instanceof KeyBindingFormatException)
            throw error
          console.error error.stack

    return
  ).on('didInsertElement')


  _processBinding: (binding) ->
    if !binding.contains(@_SEPARATORS.EQUALS)
      throw KeyBindingFormatException "Invalid format! Attribute `keyBindings` missing `#{@_SEPARATORS.EQUALS_UNPROCESSED}`. See https://github.com/mysterioustrousers/firehose-ember-shared/wiki/Mixin:-Key-Bindings#attributes for more information."


    bindingKeysAndAction = binding.split @_SEPARATORS.EQUALS
    keys       = bindingKeysAndAction[0].trim()
    actionName = bindingKeysAndAction[1].trim()


    @_processKeys keys


    # TODO: Implement Binding

    return


  _processKeys: (keys) ->
    keys = keys.normalizeSpaces()

    keys = keys.replace RegExp("#{@_SEPARATORS.GROUP_START.escapeRegex()}\\s",   'gmi'), @_SEPARATORS.GROUP_START
    keys = keys.replace RegExp("\\s#{@_SEPARATORS.GROUP_END.escapeRegex()}",     'gmi'), @_SEPARATORS.GROUP_END
    keys = keys.replace RegExp("\\s#{@_SEPARATORS.MULTIPLE_KEYS.escapeRegex()}", 'gmi'), @_SEPARATORS.MULTIPLE_KEYS
    keys = keys.replace RegExp("#{@_SEPARATORS.MULTIPLE_KEYS.escapeRegex()}\\s", 'gmi'), @_SEPARATORS.MULTIPLE_KEYS
    keys = keys.replace RegExp("\\s#{@_SEPARATORS.COMBO.escapeRegex()}",         'gmi'), @_SEPARATORS.COMBO
    keys = keys.replace RegExp("#{@_SEPARATORS.COMBO.escapeRegex()}\\s",         'gmi'), @_SEPARATORS.COMBO


    keyStrokes = []

    if keys.contains @_SEPARATORS.GROUP_START
      if !keys.contains(@_SEPARATORS.GROUP_END) || keys.occurrences(@_SEPARATORS.GROUP_START) != keys.occurrences(@_SEPARATORS.GROUP_END)
        throw KeyBindingFormatException "Invalid Format! Attribute `keyBindings` doesn't have enough group endings (`#{@_SEPARATORS.GROUP_END}`). See https://github.com/mysterioustrousers/firehose-ember-shared/wiki/Mixin:-Key-Bindings#attributes for more information."

      groups = keys.match RegExp("#{@_SEPARATORS.GROUP_START.escapeRegex()}.+?#{@_SEPARATORS.GROUP_END.escapeRegex()}", 'gmi')

      if groups?
        keysList = []

        for group in groups
          group = group.slice 1, (group.length - 1)
          group = group.trimNonSpace @_SEPARATORS.MULTIPLE_KEYS

          separator = keys.substr (keys.indexOf(group) + group.length + 1), 1 if group.length != keys.length

          keyStrokesTemp = @_processGroup group

          for keyStroke in keyStrokesTemp
            keysList.push(keyStroke)
            keysList.push(separator) if separator?

        keys = keysList.join String.EMPTY
      else
        throw KeyBindingFormatException "Invalid Format! Attribute `keyBindings` has a group(s) whose parentheses aren't in the correct order (I.E. `)` comes before `(`). See https://github.com/mysterioustrousers/firehose-ember-shared/wiki/Mixin:-Key-Bindings#attributes for more information."
    else if keys.contains @_SEPARATORS.GROUP_END
      throw KeyBindingFormatException "Invalid Format! Attribute `keyBindings` doesn't have enough group beginnings (`#{@_SEPARATORS.GROUP_START}`). See https://github.com/mysterioustrousers/firehose-ember-shared/wiki/Mixin:-Key-Bindings#attributes for more information."

    # TODO: Combine duplicated modifiers

    return


  _processGroup: (group) ->
    multipleKeyIndices = group.indicesOf @_SEPARATORS.MULTIPLE_KEYS

    multipleKeyIndices.push(group.length - 1)

    ret               = if multipleKeyIndices.length > 0 then [] else [ group ]
    isFirstIndex      = true
    multipleKeyLength = tempMultipleKey.length

    for index, i in multipleKeyIndices
      startIndex = if isFirstIndex then 0 else (multipleKeyIndices[i - 1] + multipleKeyLength)

      keyStroke = group.substr(startIndex, (index - startIndex)).trim()
      ret.push(keyStroke) if keyStroke?

      isFirstIndex = false

    ret


  _processSpecialCharacters: (bindings) ->
    if bindings.contains @_SEPARATORS.BINDINGS_ESCAPED
      bindings = bindings.replace RegExp(@_SEPARATORS.BINDINGS_ESCAPED.escapeRegex(), 'gmi'), @_SEPARATORS.BINDINGS_ESCAPED_TEMP

    if bindings.contains @_SEPARATORS.COMBO_ESCAPED
      bindings = bindings.replace RegExp(@_SEPARATORS.COMBO_ESCAPED.escapeRegex(), 'gmi'), @_SEPARATORS.COMBO_ESCAPED_TEMP

    if bindings.contains @_SEPARATORS.EQUALS_ESCAPED
      bindings = bindings.replace RegExp(@_SEPARATORS.EQUALS_ESCAPED.escapeRegex(), 'gmi'), @_SEPARATORS.EQUALS_ESCAPED_TEMP

    if bindings.contains @_SEPARATORS.GROUP_START_ESCAPED
      bindings = bindings.replace RegExp(@_SEPARATORS.GROUP_START_ESCAPED.escapeRegex(), 'gmi'), @_SEPARATORS.GROUP_START_ESCAPED_TEMP

    if bindings.contains @_SEPARATORS.GROUP_END_ESCAPED
      bindings = bindings.replace RegExp(@_SEPARATORS.GROUP_END_ESCAPED.escapeRegex(), 'gmi'), @_SEPARATORS.GROUP_END_ESCAPED_TEMP

    if bindings.contains @_SEPARATORS.MULTIPLE_KEYS_ESCAPED
      bindings = bindings.replace RegExp(@_SEPARATORS.MULTIPLE_KEYS_ESCAPED.escapeRegex(), 'gmi'), @_SEPARATORS.MULTIPLE_KEYS_ESCAPED_TEMP

    bindings = bindings.replace RegExp(@_SEPARATORS.BINDINGS_UNPROCESSED.escapeRegex(),      'gmi'), @_SEPARATORS.BINDINGS
    bindings = bindings.replace RegExp(@_SEPARATORS.COMBO_UNPROCESSED.escapeRegex(),         'gmi'), @_SEPARATORS.COMBO
    bindings = bindings.replace RegExp(@_SEPARATORS.EQUALS_UNPROCESSED.escapeRegex(),        'gmi'), @_SEPARATORS.EQUALS
    bindings = bindings.replace RegExp(@_SEPARATORS.GROUP_START_UNPROCESSED.escapeRegex(),   'gmi'), @_SEPARATORS.GROUP_START
    bindings = bindings.replace RegExp(@_SEPARATORS.GROUP_END_UNPROCESSED.escapeRegex(),     'gmi'), @_SEPARATORS.GROUP_END
    bindings = bindings.replace RegExp(@_SEPARATORS.MULTIPLE_KEYS_UNPROCESSED.escapeRegex(), 'gmi'), @_SEPARATORS.MULTIPLE_KEYS

    bindings = bindings.replace RegExp(@_SEPARATORS.BINDINGS_ESCAPED_TEMP.escapeRegex(),      'gmi'), @_SEPARATORS.BINDINGS_UNPROCESSED
    bindings = bindings.replace RegExp(@_SEPARATORS.COMBO_ESCAPED_TEMP.escapeRegex(),         'gmi'), @_SEPARATORS.COMBO_UNPROCESSED
    bindings = bindings.replace RegExp(@_SEPARATORS.EQUALS_ESCAPED_TEMP.escapeRegex(),        'gmi'), @_SEPARATORS.EQUALS_UNPROCESSED
    bindings = bindings.replace RegExp(@_SEPARATORS.GROUP_START_ESCAPED_TEMP.escapeRegex(),   'gmi'), @_SEPARATORS.GROUP_START_UNPROCESSED
    bindings = bindings.replace RegExp(@_SEPARATORS.GROUP_END_ESCAPED_TEMP.escapeRegex(),     'gmi'), @_SEPARATORS.GROUP_END_UNPROCESSED
    bindings = bindings.replace RegExp(@_SEPARATORS.MULTIPLE_KEYS_ESCAPED_TEMP.escapeRegex(), 'gmi'), @_SEPARATORS.MULTIPLE_KEYS_UNPROCESSED

    if bindings.contains(@_ESCAPE_CHAR_ESCAPED) then bindings.replace(RegExp(@_ESCAPE_CHAR_ESCAPED.escapeRegex(), 'gm'), @_ESCAPE_CHAR) else bindings


  KeyBindingFormatException: (msg) ->
    message = msg
    return
