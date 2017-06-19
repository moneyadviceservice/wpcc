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

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
