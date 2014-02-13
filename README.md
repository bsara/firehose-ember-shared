firehose-ember-shared
=====================

Shared components among Firehose client ember apps


### Usage

**NOTE**: This is not meant to be cloned down as an independent repo. It is inteded to be included in ember projects as a submodule.

I suggest adding it as a submodule in

    source/js/[application]/shared
    
So, in the browser app, I'm going to add it like (assuming I'm in the root of the browser project):

    $ git submodule add https://github.com/mysterioustrousers/firehose-ember-shared.git source/assets/js/firehose/shared

Then, in my `source/js/firehose/app.js.coffee file:

    #= require_self
    #= require_tree ./misc
    #= require_tree ./mixins
    #= require ember-view-animate
    #= require_tree ./view_models
    #= require_tree ./controllers
    #= require_tree ./views
    #= require_tree ./helpers
    #= require_tree ./components
    #= require_tree ./shared        <= I would add this line so all shared componetns will be included when ember loads.
    #= require_tree ./templates
    #= require_tree ./routes
    #= require ./router
    
### Staying up-to-date

Periodically, it's a good idea to keep your shared submodule up to date. You would do this by:

    cd source/js/[application]/shared
    git stash
    git pull -r origin master
    git stash apply
    
[Stash?](http://ndpsoftware.com/git-cheatsheet.html)

### Contributing

And then, of course, if you make any changes to anything in the shared submodule, you would:

    cd source/js/[application]/shared
    git add . -A
    git commit -am 'I did blah blah blah.'
    git pull -r origin master
    git push origin master

to update the shared repo.
