firehose-ember-shared
=====================

Shared components among Firehose client ember apps


### Install

**NOTE**: This is not meant to be cloned down as an independent repo. It is inteded to be included in ember projects as a submodule.

Add this as a submodule in your root project directory:

    $ git submodule add https://github.com/mysterioustrousers/firehose-ember-shared.git shared

Then, run the following script to create a post-receive hook that will symlink all shared files into their respective path in your project.

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
          | +-templates/
          | | |
          | | +-components/
          | |
          | +-views/
          |
          +-vendor/
            
Obviously, an ember app is going to have a lot more than just that, but that's the min. that needs to be present. Otherwise `/.update` is going to create these directories and symlink the files to the wrong locations.


### Contributing

Of course, if you make any changes to anything in the shared submodule, you would:

    cd shared
    git add . -A
    git commit -am 'I did blah blah blah.'
    git pull -r origin master
    git push origin master

to update the shared repo.
