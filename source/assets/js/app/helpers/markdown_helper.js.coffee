Ember.Handlebars.registerBoundHelper 'markdown', (md, addCSSClass) ->
  addCSSClass = if !addCSSClass? || typeof addCSSClass != 'boolean' then true else addCSSClass
  if md
    md = md.replace /(^|\s)(http.+?)(\s|$)/ig, "$1[$2]($2)$3"
    html = marked md
    new Handlebars.SafeString "<div#{if addCSSClass == false then "" else " class='firehose-markdown'"}>#{html}</div>"