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

The main application.js requies the component loader to be present in order to
load the dough components

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

## Tests
When running Rspec, SimpleCov will also measure the code coverage with a minimum requirement of 85% coverage.
This value will be displayed at the end of your Rspec tests.

To view the coverage output open `coverage/index.html` in your browser.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
