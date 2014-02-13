firehose-ember-shared
=====================

Shared components among Firehose client ember apps


### Usage

This is not meant to be cloned down as an independent repo. It is inteded to be included in ember projects as a submodule.

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
