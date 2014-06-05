if typeof String.EMPTY == 'undefined' || !String.EMPTY?
  String.EMPTY = ""


if typeof String::trimNonSpace == 'undefined'
  String::trimNonSpace = (stringToTrim) ->
    escapedStringToTrim = stringToTrim.escapeRegex()
    return @replace RegExp("(^#{escapedStringToTrim}+|#{escapedStringToTrim}+$)", 'gm'), String.EMPTY


if typeof String::contains == 'undefined'
  String::contains = (searchString) ->
    return (@indexOf(searchString) > -1)


if typeof String::indicesOf == 'undefined'
  String::indicesOf = (searchString) ->
    indices     = []
    startIndex  = 0
    resultIndex = -1

    while true
      resultIndex = @indexOf(searchString, startIndex)

      if resultIndex < 0
        break

      indices.push(resultIndex)
      startIndex = resultIndex + searchString.length

    return indices


if typeof String::truncate != 'function'
  String::truncate = (max_chars) ->
    str = this
    if @length > max_chars
      str = @substring(0, max_chars - 3) + '...'
    return String(str)


if typeof String::linkify != 'function'
  String::linkify = ->
    return @replace /((http|mailto).*?)(?=\s|$|<|")/ig, '<a href="$1" target="_blank">$1</a>'


if typeof String::htmlize != 'function'
  String::htmlize = ->
    s = this
    s = s.replace /\n/g, "<br/>"
    return s.linkify()


if typeof String::stripTags != 'function'
  String::stripTags = ->
    return @replace /(<([^>]+)>)/ig, String.EMPTY


if typeof String::cleanTextOnly != 'function'
  String::cleanTextOnly = ->
    # return @stripTags().replace(/(\s|[^a-zA-Z0-9,".!?()\-:@])/ig," ")
    return @stripTags().replace /\s/ig, " "


if typeof String::validDateString != 'function'
  String::validDateString = ->
    return @replace /(\d{4})-(\d{2})-(\d{2})[^\d](\d{2}):(\d{2}):(\d{2}).*/, '$1-$2-$3T$4:$5:$6Z'


if typeof String::facebookIdToLinkId != 'function'
  String::facebookIdToLinkId = ->
    return @replace /.+?_/ig, String.EMPTY


if typeof String::to_cookie != 'function'
  String::to_cookie = (key) ->
    document.cookie = key + "=" + this
    return


if typeof String::from_cookie != 'function'
  String::from_cookie = ->
    cookies = document.cookie.split ";"
    for cookie in cookies
      x = cookie.substr 0, cookie.indexOf("=")
      y = cookie.substr(cookie.indexOf("=") + 1)
      x = x.replace /^\s+|\s+$/g, String.EMPTY
      if x == this
        return unescape y
    return null


if typeof String::secure_twitter_image != 'function'
  String::secure_twitter_image = ->
    return @replace /http:\/\/a.\.twimg\.com\//ig, "https://s3.amazonaws.com/twitter_production/"


if typeof String::capitalized != 'function'
  String::capitalized = ->
    return @charAt(0).toUpperCase() + @replace("_", " ").slice(1)


if typeof String::startsWith != 'function'
  String::startsWith = (startString) ->
    return (@slice(0, startString.length) == startString)


if typeof String::endsWith != 'function'
  String::endsWith = (endString) ->
    return (@slice(-endString.length) == endString)


if typeof String::escapeRegex != 'function'
  String::escapeRegex = () ->
    return @replace(/\\/gm, "\\\\")
            .replace(/\//gm, "\\/")
            .replace(/\./gm, "\\.")
            .replace(/\*/gm, "\\*")
            .replace(/\+/gm, "\\+")
            .replace(/\?/gm, "\\?")
            .replace(/\|/gm, "\\|")
            .replace(/\(/gm, "\\(")
            .replace(/\)/gm, "\\)")
            .replace(/\[/gm, "\\[")
            .replace(/\]/gm, "\\]")
            .replace(/\{/gm, "\\{")
            .replace(/\}/gm, "\\}")


if typeof String::unescapeRegex != 'function'
  String::unescapeRegex = () ->
    return @replace(/\\\}/gm, "}")
            .replace(/\\\{/gm, "{")
            .replace(/\\\]/gm, "]")
            .replace(/\\\[/gm, "[")
            .replace(/\\\)/gm, ")")
            .replace(/\\\(/gm, "(")
            .replace(/\\\|/gm, "|")
            .replace(/\\\?/gm, "?")
            .replace(/\\\+/gm, "+")
            .replace(/\\\*/gm, "*")
            .replace(/\\\./gm, ".")
            .replace(/\\\//gm, "/")
            .replace(/\\\\/gm, "\\")


if typeof String::occurrenceCount != 'function'
  String::occurrenceCount = (searchString, caseSensitive) ->
    if !caseSensitive? || typeof caseSensitive != 'boolean'
      caseSensitive = false
    return @match(RegExp(searchString.escapeRegex(), "gm#{if caseSensitive then String.EMPTY else "i"}")).length


if typeof String::normalizeSpaces != 'function'
  String::normalizeSpaces = () ->
    str   = this
    regex = RegExp "\\s\\s", 'gm'

    while str.match(regex)
      str = str.replace regex, " "
    return str



