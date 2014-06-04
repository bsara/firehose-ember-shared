Firehose Ember Shared
=====================

Shared components among Firehose client ember apps



## API Reference

- [Ember Components](https://github.com/mysterioustrousers/firehose-ember-shared/wiki#ember-components)
- [Ember Mixins](https://github.com/mysterioustrousers/firehose-ember-shared/wiki#ember-mixins)
- [Handlebars Helpers](https://github.com/mysterioustrousers/firehose-ember-shared/wiki#handlebars-helpers)
- [Misc](https://github.com/mysterioustrousers/firehose-ember-shared/wiki#misc)
- [Vendor Libraries](https://github.com/mysterioustrousers/firehose-ember-shared/wiki#vendor-libraries)



## Install

**NOTE**: This is not meant to be cloned down as an independent repo. It is inteded to be included in ember projects as a submodule.

If you are creating a new client app, add this as a submodule in your root project directory:

    $ git submodule add https://github.com/mysterioustrousers/firehose-ember-shared.git shared



## Configuring Shared Components

If you are cloning an existing client app that already contains this repo as a submodule (such as `firehose-browser`, `firehose-billing`, etc.), run these commands to configure the submodule for the first time:

    $ git submodule init
    $ git submodule update

This will update the `shared` folder, in the root directory of every project, with all the shared files. Then, run the following script to create a post-receive hook that will symlink all shared files into their respective path in your project.

    $ cd shared && ./install

After that, `/.update` will be run after each `git pull`. You can also run `/.update` manually from within the `shared` submodule and it will update the symlinks.



#### Required Project Structure

The shared repo directory structure is a subset mirror of your project, start with the "source" directory. So, your project **MUST** follow the following project structure:

    +-source/
      |
      +-assets/
        |
        +-css/
        | |
        | +-app/
        | | |
        | | +-components/
        | |
        | +-vendor/
        |
        +-img/
        | |
        | +-app/
        |   |
        |   +-components/
        |
        +-js/
          |
          +-app/
          | |
          | +-components/
          | |
          | +-helpers/
          | |
          | +-misc/
          | |
          | +-mixins/
          | |
          | +-templates/
          | | |
          | | +-components/
          | |
          | +-views/
          |
          +-vendor/

Obviously, an ember app is going to have a lot more than just that, but that's the min. that needs to be present. Otherwise `/.update` is going to create these directories and symlink the files to the wrong locations.



## Contributing

Of course, if you make any changes to anything in the shared submodule, you would:

    cd shared
    git add . -A
    git commit -am 'I did blah blah blah.'
    git pull -r origin master
    git push origin master

to update the shared repo.