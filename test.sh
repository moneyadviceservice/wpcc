#!/bin/bash

set -e -x

export RAILS_ENV=test
export BUNDLE_WITHOUT=development

bundle install
bundle exec rubocop .
bundle exec bowndler install

bundle exec rspec
bundle exec cucumber

karma start spec/javascripts/karma.conf.js --single-run
