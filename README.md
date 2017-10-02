# Wpcc

All the things for Money Advice Service's Workplace Pension Contribution Calculator.

## Prerequisites

* [Git](http://git-scm.com)
* [Rbenv](https://github.com/rbenv/rbenv)
* [Ruby][Ruby] - see version specified in [Gemfile](Gemfile)

## Installation

Clone the repository:

Install ruby dependencies
```sh
$ gem install bundler
$ bundle
$ bowndler install
```

Install npm modules:

```sh
npm install
```

## Hooks

This project uses git hooks to make sure every change is following the best
practices like running the code lints and the tests.

In order to use the hooks just run this commands:

```sh
  cp hooks/pre-push .git/hooks/pre-push
  chmod u+x .git/hooks/pre-push
```

Note: *It is not recommended but if you want to ignore the hook, you can run*:

```
git push --no-verify origin <your_branch>
```

## Versioning
When a new version of the gem is ready to be published:
- Create your feature branch
- Make a commit updating the following:
  - version number in `lib/wpcc/version.rb` - for reference see the [semver documentation](semver.org)
  - Add what changes have been made between current and the new version in `history.md`
- Create a PR for review
- Once approved, merge the PR into master
- On `master` branch, tag the repo with the latest version number
  - `git tag 'v1.2.0'`
- Push the tag to github
  - `git push origin master --tags`
- check the [wpcc](https://go.dev.mas.local/go/tab/pipeline/history/wpcc) Go build completes

## Mounting the engine

The application that mounts this engine requires a controller to be the parent
controller of this engine. You can do in an initializer like below:

```
# config/initializers/wpcc.rb
Wpcc.parent_controller = '::ApplicationController'
```

Note that the "ApplicationController" is just an example. It could be whatever
controller you need.

The Parent controller above needs a before_action to set the locale in order to
implement internationalisation.

```ruby
  class ApplicationController < ActionController::Base
    before_action :set_locale

    def set_locale
      I18n.locale = params[:locale]
    end
  end
```

The main app require_config.js should have the wpccConfig on the path.
An example:

```
  requirejs_config = {
    paths: {
      wpccConfig: requirejs_path('wpcc/require_config')
    }
  }
```

Obs.: This "wpccConfig" name should be required using the "require" clause of
the require js. The main application also requires the component loader to
be present in order to load the dough components and the wpcc components:

```
require(['wpccConfig'], function() {
  require(['componentLoader'], function (componentLoader) {
    componentLoader.init($('body'));
  });
});
```

In order for the component loader to function correctly, the parent_template
is required to set up the responsibility of the main app to render the html,
head and body tags:

``wpcc/spec/dummy/app/controllers/application_controller.rb``
```ruby
def parent_template
  'layouts/application'
end
helper_method :parent_template
```

The WPCC engine layout uses content_for tags for both the head
and main content, and also the and instruction to render the parent template.

``app/views/layouts/wpcc/engine.html.erb``

```
<html>
  <head>
    <% content_for(:head) do %>
      <title>Wpcc</title>
      <%= stylesheet_link_tag "wpcc/application", media: "all" %>
      <%= javascript_include_tag "wpcc/application" %>
    <% end %>
  </head>
  <body>
    <% content_for(:engine_content) do %>
      <%= yield %>
    <% end %>
  </body>
</html>
<%= render template: parent_template %>
```

With all of the above complete, it is required that the dummy template application
layout includes the instruction to render the head and engine content from the
main application, so that the assets and JS are avaiable to the dummy app.

``
spec/dummy/app/views/layouts/application.html.erb
``
```
<!DOCTYPE html>
<html>
  <head>
    <%= yield(:head) %>
  </head>
  <body>
    <%= yield(:engine_content) %>

    <!--[if ( !IE ) | ( gte IE 9 ) ]><!-->
      <%= javascript_include_tag 'requirejs/require', data: {main: javascript_path('application')} %>
    <!--<![endif]-->
  </body>
</html>
```

## Dependencies

There are 2 dependencies listed in ``wpcc.gemspec`` each are required for correct display and functionality of the tool.

### dough-ruby

Contains UI components and helpers for tool features.  Also contains the component loader and 
base component of which all internal components are based.

### meta-tags

This dependency allows the injection of meta tags into the ``<head>`` of the markup. 
While this is used to add SEO content to the frontend project, the dependency is required
within the tool to prevent undefined method errors in the dummy app.

## Tests

### Running tests on your Mac

To run the tests (rspec, cucumber and karma), just run:

```
./test.sh
```

When running Rspec, SimpleCov will also measure the code coverage with a minimum requirement of 85% coverage.
This value will be displayed at the end of your Rspec tests.

To view the coverage output open `coverage/index.html` in your browser.

### Running tests in Docker

If you have Docker setup and want to run the tests in a more isolated
environment, run `./script/docker_test`. This will run the tests exactly
as they are run under Jenkins.

## Code Quality
### Rubocop
The build script has been set up to fail if the code quality does not meet expectations as set out in the standard Rubocop file. The code quality standards have been set out in this file`.rubocop.yml`, which is within this project.

#### Run Rubocop on all applicable files
Run Rubocop locally with this command, `$ bundle exec rubocop .`

#### Run Rubocop on a single file
`$ bundle exec rubocop app/models/wpcc/your_details_form.rb`

#### Run Rubocop over a directory
`$ bundle exec rubocop app/`

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
