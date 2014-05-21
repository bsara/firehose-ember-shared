Ember.Handlebars.registerBoundHelper 'markdown', (md) ->
  if md
    md = md.replace /(^|\s)(http.+?)(\s|$)/ig, "$1[$2]($2)$3"
    html = markdown.toHTML md
    new Handlebars.SafeString '<div class="firehose-markdown">#{html}</div>'