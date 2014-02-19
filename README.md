firehose-ember-shared
=====================

Shared components among Firehose client ember apps


### Install

**NOTE**: This is not meant to be cloned down as an independent repo. It is inteded to be included in ember projects as a submodule.

Add this as a submodule in your root project directory:

    $ git submodule add https://github.com/mysterioustrousers/firehose-ember-shared.git shared

Then, run the following script to create symlinks in your project to shared files.

    $ cd shared && ./install
    
The shared repo directory structure is a subset mirror of your project, start with the "source" directory. So, your project **MUST** follow the following project structure:

    +-shared/
      |
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
          +-js/
            |
            +-app/
            | |
            | +-components/
            | |
            | +-templates/
            | | |
            | | +-components/
            | |
            | +-views/
            |
            +-vendor/
            
Obviously, an ember app is going to have a lot more than just that, but that's the min. that needs to be present. Otherwise `/.install` is going to create these directories and symlink the files to the wrong locations.

    
### Staying up-to-date

Periodically, it's a good idea to keep your shared submodule up to date. You would do this by:

    $ cd shared
    $ git pull -r origin master
    $ ./install
    

### Contributing

And then, of course, if you make any changes to anything in the shared submodule, you would:

    cd source/js/[application]/shared
    git add . -A
    git commit -am 'I did blah blah blah.'
    git pull -r origin master
    git push origin master

to update the shared repo.
