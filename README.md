Firehose Ember Shared
=====================

Shared components among Firehose client ember apps


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



## Components

This shared library contains many components and other types of Ember classes that will be symlinked into your project. This is a list of the components that will be added and instructions on how to use them in your application.

This list is ordered alphabetically.

-----------------------------------------

### Colorpicker Text Field

This is an extended version of a normal text field (Normal text field: `{{input type="text" ...}}`) that, when clicked, reveals a color picker which can be used to set the value of the text field. The default functionality of this field is to pop up the color picker below the text field and the chosen color will be reflected as a hexidecimal number in the value of the text field.

The color picker used for this component can be found here: https://github.com/bsara/pickacolor.js


#### Usage

Remember that this component is just an extended version of a normal text field. You can use all attributes that are available to a normal text field. __The only exception is the `type` attribute, it is not allowed.__

    {{input-colorpicker-text ...}}


#### Additional Attributes (All are optional)

- `allCaps` - When true, all capital letters are used for hex representations of colors.
  - __Type:__ `boolean`
  - __Default:__ `true`
- `hideButtons` - When true, the cancel and submit buttons will not be available on the color picker.
  - __Type:__ `boolean`
  - __Default:__ `true`
- `defaultColor` - The default color. String for hex color or hash for RGB and HSB ({r:255, r:0, b:0}).
  - __Type:__ `string`
  - __Default:__ `"FF0000"`
- `livePreview` - Whether the color values are filled in the fields while changing values on selector or a field. If false it may improve speed.
  - __Type:__ `boolean`
  - __Default:__ `true`
- `onBeforeCancelAction` - Ember action to perform during `onBeforeCancel`.
  - __Type:__ `ember action name`
- `onBeforeShowPickerAction` - Ember action to perform during `onBeforeShowPicker`.
  - __Type:__ `ember action name`
- `onChangePickerAction` - Ember action to perform during `onChangePicker`.
  - __Type:__ `ember action name`
- `onHidePickerAction` - Ember action to perform during `onHidePicker`.
  - __Type:__ `ember action name`
- `onShowPickerAction` - Ember action to perform during `onShowPicker`.
  - __Type:__ `ember action name`
- `onSubmitPickerAction` - Ember action to perform during `onSubmitPicker`.
  - __Type:__ `ember action name`
- `pickerPosition` - Determines where the color picker will appear relative to the text field. If a value is given that is not listed below, then the default will be used.
  - __Type:__ `enum`
  - __Options:__
    - `"top-left"` - The picker's bottom left corner will touch the text field's top left corner.
    - `"top-right"` - The picker's bottom right corner will touch the text field's top right corner.
    - `"bottom-left"` __default__ - The picker's top left corner will touch the text field's bottom left corner.
    - `"bottom-right"` - The picker's top right corner will touch the text field's bottom right corner.
    - `"left"` - The picker's right side will touch the text field's left side and be centered with the text field.
    - `"left-top"` - The picker's bottom right corner will touch the text field's bottom left corner.
    - `"left-bottom"` - The picker's top right corner will touch the text field's top left corner.
    - `"right"` - The picker's left side will touch the text field's right side and be centered with the text field.
    - `"right-top"` - The picker's bottom left corner will touch the text field's bottom right corner.
    - `"right-bottom"` - The picker's top left corner will touch the text field's top right corner.
- `popup`: Whether the color picker is appended to the element or triggered by an event.
  - __Type:__ `boolean`
  - __Default:__ `false`
- `popupEvent`: The desired event to trigger the color picker (only used if `popup` is `true`).
  - __Type:__ `string`
  - __Default:__ `"click"`
- `setColorEvent` - The event on which the color should be set as the current color and the elements specified by `valueSelector` and `styleSelector` should be updated accordingly. If a value is given that is not listed below, then the default will be used.
  - __Type:__ `enum`
  - __Options:__
    - `"change"` __default__
    - `"hide"`
    - `"submit"`
- `styleAttribute` - The CSS attribute to update for the object(s) specified by `styleSelector`. (__NOTE:__ Specifying multiple attributes is NOT currently supported.)
  - __Type:__ `string`
  - __Default:__ `"color"`
- `styleSelector` - Used to find all elements that should have their CSS updated when the color is updated.
  - __Type:__ `jQuery Selector`
  - __Default:__ `null`
- `valueSelector` - Used to find all elements that should have their values updated when the color is updated.
  - __Type:__ `jQuery Selector`
  - __Default:__ `this`


#### Additional Events (All are optional)

- `onBeforeCancelPicker` - Callback function triggered before the color picker is cancelled. If not explicitly set, a default function will be used.
- `onBeforeShowPicker` - Callback function triggered before the color picker is shown. If not explicitly set, a default function will be used.
- `onCancelPicker` - Callback function triggered when the color picker cancel is clicked. If not explicity set, a default function will be used.
- `onChangePicker` - Callback function triggered when the color is changed. If not explicitly set, a default function will be used.
- `onHidePicker` - Callback function triggered when the color picker is hidden. If not explicitly set, a default function will be used.
- `onShowPicker` - Callback function triggered when the color picker is shown. If not explicitly set, a default function will be used.
- `onSubmitPicker` - Callback function triggered when the color it is chosen. If not explicitly set, a default function will be used.

-----------------------------------------

### Extended Text Area

Extended Text Area is an extended verion of a normal text area (Normal text area: `{{textarea ...}}`).


#### Usage

Remember that this component is just an extended version of a normal text area. You can use all attributes that are available to a normal text area.

    {{input-textarea ...}}


#### Additional Attributes

- `clickAction` (Optional)
  - The ember.js action to call when the text area is clicked. If not set, then no actions will be called.
  - __NOTE:__ Action parameters are currently __NOT__ supported but will likely be added in the future.
- `doFocus` (Optional)
  - If set to `true`, then the text area will receive focus as soon as it is added to the DOM.
  - __NOTE:__ If multiple fields are placed on a single page with this attribute set to `true`, then the last of those fields added to the DOM will receive the focus.

-----------------------------------------

### Extended Text Field

Extended Text Field is an extended verion of a normal text field (Normal text field: `{{input type="text" ...}}`).


#### Usage

Remember that this component is just an extended version of a normal text field. You can use all attributes that are available to a normal text field. The only exception is the `type` attribute, it is not allowed.

    {{input-text clickAction=myAction doFocus=true ...}}


#### Additional Attributes

- `clickAction` (Optional)
  - The ember.js action to call when the text field is clicked. If not set, then no actions will be called.
  - __NOTE:__ Action parameters are currently __NOT__ supported but will likely be added in the future.
- `doFocus` (Optional)
  - If set to `true`, then the text field will receive focus as soon as it is added to the DOM.
  - __NOTE:__ If multiple fields are placed on a single page with this attribute set to `true`, then the last of those fields added to the DOM will receive the focus.

-----------------------------------------

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

-----------------------------------------

### Markdown Editor

The `markdown-editor` template helper allows you to use a supercharged text view in your template. It has features like text completion and drag-and-drop file uploads and surely there are more features to come.  You can insert into a template using the helper like so:

	{{markdown-editor
	completions=cannedResponses 				// The list of strings that will be suggested when they type a `$` character.
	value=responseDraft 						// The object the text value of the text view should bind to.
	becameActive="markdownEditorWasAdded" 		// The message to send to the current templates controller when the text view becomes active.
	placeholder="Type your response here"}}

-----------------------------------------

### Modal

Modals are components that are rendered into your application template and appear in response to the user clicking on a `modal-anchor`. An overlay will be placed behind
the modal so that the user cannot interact with anything outside the modal. Clicking anywhere outside the modal will close it. A close button will also be provided in the top right corner of the modal for the user to close

First, you need to provide an outlet for the modal to be rendered into. This must go somewhere after your main `{{outlet}}` in your `application.hbs` template:

  {{outlet modal}}

Next make sure you include the `App.ModalEventsMixin` in your `ApplicationRoute`:

  App.ApplicationRoute = Ember.Route.extend App.ModalEventsMixin,

Finally, use the `modal-anchor` template helper to render a link in your template that will trigger the opening of a modal:

    {{#modal-anchor
    name='newCannedResponseModal' // The name of the controller that will manage this modal. In this case `App.NewCannedResponseModalController`
    model=this            // The object that should be passed to the controller as it's model.
    classNames="ico fast"       // Any standard ember view helper attributes you want to add.
    tagName="button"
    size="600,600"          // The size of the popover. Content taller than the popover will be vertically scrollable.
    }}Anchor Text{{/modal-anchor}}

The line breaks are for comments, but as you can see it looks pretty nice on one line in your template:

  {{#modal-anchor name='newCannedResponseModal' model=this classNames="ico fast" tagName="button" size="600,600"}}Markdown{{/modal-anchor}}

-----------------------------------------

### Popover

Popovers are components that are rendered into your application template and appear in response to the user clicking on a `popover-anchor`. An overlay will be placed behind
the popover so that the user cannot interact with anything outside the popover. Clicking anywhere outside the popover will close it.

First, you need to provide an outlet for the popover to be rendered into. This must go somewhere after your main `{{outlet}}` in your `application.hbs` template:

    {{outlet popover}}

Next make sure you include the `App.PopoverEventsMixin` in your `ApplicationRoute`:

  App.ApplicationRoute = Ember.Route.extend App.PopoverEventsMixin,

Finally, use the `popover-anchor` template helper to render a link in your template that will trigger the opening of a popover:

  {{#popover-anchor
    name='companyPickerPopover'   // The name of the controller that will manage this popover. In this case `App.CompanyPickerPopoverController`
    model=companies         // The object that should be passed to the controller as it's model.
    classNames="badge"        // Any standard ember view helper attributes you want to add.
    arrow="left"          // Which side of the popover the arrow pointing up should be on. Possible values: `left` or `right`.
    size="250,150"          // The size of the popover. Content taller than the popover will be vertically scrollable.
    offset="0,15"         // How far offset from this anchor you want the popover to appear. Use this to get the arrow to point right where you want.
    }}Anchor text{{/popover-anchor}}

-----------------------------------------

### Spinner

The `firehose-spinner` template helper makes it really easy to insert a spinner into your template. In Ember, the vast majority of the time, you will just need to create a `loading.hbs` template for each route that will take time to load. For example, you might create an application `loading.hbs` that looks like this:

##### loading.hbs

	<div class="overlay">
  		{{firehose-spinner}}
	</div>

That will display a spinner in the applications main `{{outlet}}` until content is available. Then you could also do other route specific loading templates like so:

##### customers/loading.hbs

	<section id="messages" class="conversation js-interactions-list">
  		{{firehose-spinner color="#000" length="5" width="2" radius="30"}}
	</section>

-----------------------------------------

### Tag Input

Tag input is a token field that allows you to add and remove tokens. You can also provide a list of string that will be suggested while new tokens are being typed.

      {{tag-input
      availableTags=searchCompletions 			// Array of strings that should be suggested to the user as possible tags as they type.
      prepopulateWithTags=savedSearchTokens 	// Any tags that should already be in the field when it's added to the DOM.
      tagWasAdded="tagWasAdded" 				// The action to send to the controller of the current template when a tag is added.
      tagWasRemoved="tagWasRemoved"
      classNames="search"
      placeholder="Search by @, #, or keyword"}}

-----------------------------------------


## Depricated Components

These components are old and will likely be removed from this library in the near future, you should take the time to update your code to supported components before this happens. If a component is no longer listed in this section nor in the Components section, then it was been removed from the library.

This list is ordered alphabetically.

-----------------------------------------

## **NO DEPRICATED COMPONENTS AT THIS TIME**

-----------------------------------------



## Contributing

Of course, if you make any changes to anything in the shared submodule, you would:

    cd shared
    git add . -A
    git commit -am 'I did blah blah blah.'
    git pull -r origin master
    git push origin master

to update the shared repo.