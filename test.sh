#!/bin/bash

set -e -x

export RAILS_ENV=test
export BUNDLE_WITHOUT=development

npm install
bundle install
bundle exec rubocop .
bundle exec bowndler install

bundle exec rspec
bundle exec cucumber

./node_modules/karma/bin/karma start spec/javascripts/karma.conf.js --single-run
