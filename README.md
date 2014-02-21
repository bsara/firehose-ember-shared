firehose-ember-shared
=====================

Shared components among Firehose client ember apps


## Install

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


## Components

This shared library contains many components and other types of Ember classes that will be symlinked into your project. This is a list of the components that will be added and instructions on how to use them in your application.

### Popover

Popovers are components that are rendered into your application template and appear in response to the user clicking on a `popover-anchor`. An overlay will be placed behind
the popover so that the user cannot interact with anything outside the popover. Clicking anywhere outside the popover will close it.

First, you need to provide an outlet for the popover to be rendered into. This must go somewhere after your main `{{outlet}}` in your `application.hbs` template:

	{{outlet popover}}

Use the `popover-anchor` template helper to render a link in your template that will trigger the opening of a popover:

	{{#popover-anchor 
    name='companyPickerPopover'		// The name of the controller that will manage this popover. In this case `App.CompanyPickerPopoverController` 
    model=companies					// The object that should be passed to the controller as it's model.
    classNames="badge" 				// Any standard ember view helper attributes you want to add.
    arrow="left" 					// Which side of the popover the arrow pointing up should be on. Possible values: `left` or `right`.
    size="250,150"					// The size of the popover. Content taller than the popover will be vertically scrollable.
    offset="0,15"					// How far offset from this anchor you want the popover to appear. Use this to get the arrow to point right where you want.
    }}Anchor text{{/popover-anchor}}
    
### Modal

Modals are components that are rendered into your application template and appear in response to the user clicking on a `modal-anchor`. An overlay will be placed behind
the modal so that the user cannot interact with anything outside the modal. Clicking anywhere outside the modal will close it. A close button will also be provided in the top right corner of the modal for the user to close

First, you need to provide an outlet for the modal to be rendered into. This must go somewhere after your main `{{outlet}}` in your `application.hbs` template:

	{{outlet modal}}
	
Use the `modal-anchor` template helper to render a link in your template that will trigger the opening of a modal:
    
    {{#modal-anchor 
    name='newCannedResponseModal'	// The name of the controller that will manage this modal. In this case `App.NewCannedResponseModalController` 
    model=this 						// The object that should be passed to the controller as it's model.
    classNames="ico fast" 			// Any standard ember view helper attributes you want to add.
    tagName="button" 				
    size="600,600"					// The size of the popover. Content taller than the popover will be vertically scrollable.
    }}Anchor Text{{/modal-anchor}}
    
The line breaks are for comments, but as you can see it looks pretty nice on one line in your template:

	{{#modal-anchor name='newCannedResponseModal' model=this classNames="ico fast" tagName="button" size="600,600"}}Markdown{{/modal-anchor}}

### Markdown Editor

The `markdown-editor` template helper allows you to use a supercharged text view in your template. It has features like text completion and drag-and-drop file uploads and surely there are more features to come.  You can insert into a template using the helper like so:

	{{markdown-editor 
	completions=cannedResponses 				// The list of strings that will be suggested when they type a `$` character.
	value=responseDraft 						// The object the text value of the text view should bind to.
	becameActive="markdownEditorWasAdded" 		// The message to send to the current templates controller when the text view becomes active.
	placeholder="Type your response here"}}

### Loading Button

The loading button shows a different title depending on its state and most importantly, passes a callback with it's sent action so that any operation the button triggers can tell the button to reset it's state to it's original title once the operation is complete or failed.

	{{loading-button class="primary send" action="send" buttonText="Send" loadingText="Sending…"}}

Then in the controller for the template this is used in:

	actions:
    	send: (done) ->
			interaction = this.get('model')
			interaction.reply().done ->
				interaction.set 'responseDraft', ''
			.always ->
				done()

As you can see, a `done` callback is passed along and should be called when the button can return to it's normal state when operation completes.

### Spinner

The `firehose-spinner` template helper makes it really easy to insert a spinner into your template. In Ember, the vast majority of the time, you will just need to create a `loading.hbs` template for each route that will take time to load. For example, you might create an application `loading.hbs` that looks like this:

##### loading.hbs

	<div class="overlay">
  		{{firehose-spinner}}
	</div>

That will display a spinner in the applications main `{{outlet}}` until content is available. Then you could also do other route specific loading templates like so:

##### customers/loading.hbs

	<section id="messages" class="conversation js-interactions-list">
  		{{firehose-spinner}}
	</section> 


### Tag Input

Tag input is a token field that allows you to add and remove tokens. You can also provide a list of string that will be suggested while new tokens are being typed.

      {{tag-input 
      availableTags=searchCompletions 			// Array of strings that should be suggested to the user as possible tags as they type.
      prepopulateWithTags=savedSearchTokens 	// Any tags that should already be in the field when it's added to the DOM.
      tagWasAdded="tagWasAdded" 				// The action to send to the controller of the current template when a tag is added.
      tagWasRemoved="tagWasRemoved"
      classNames="search" 
      placeholder="Search by @, #, or keyword"}}
      
### Focus Text Field and Text View

The `focus-textfield` and `focus-textarea` are just extended text inputs that are given focus as soon as they are added to the DOM. Use them exactly as you would the ember `textfield` and `textarea` helpers provided by Ember.js.


## Contributing

Of course, if you make any changes to anything in the shared submodule, you would:

    cd shared
    git add . -A
    git commit -am 'I did blah blah blah.'
    git pull -r origin master
    git push origin master

to update the shared repo.
