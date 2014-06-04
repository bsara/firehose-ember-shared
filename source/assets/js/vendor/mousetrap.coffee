(($) ->
  $.fn.mousetrapBind = (keys, callback) ->
    elements = this

    tempReplacement1 = "<TEMP1>"
    tempReplacement2 = "<TEMP2>"
    separatorReplacement = "<;>"
    tempKeys = keys.trim()
                   .normalizeSpaces()
                   .replace("\\\\", tempReplacement1)
                   .replace("\\;", tempReplacement2)
                   .replace(";", separatorReplacement)
                   .replace(tempReplacement2, ";")
                   .replace(tempReplacement1, "\\")
    keysArray = if (tempKeys.indexOf(separatorReplacement) > -1) then tempKeys.split(separatorReplacement) else [ tempKeys ]

    keysArray.forEach (arrayItem) ->
      Mousetrap.bindGlobal arrayItem, () ->
        element = elements.filter ':focus'
        if element && element.length
          callback element, arrayItem
)(jQuery)