#!/bin/bash

set -e -x

export RAILS_ENV=test
export BUNDLE_WITHOUT=development

npm install -q
bundle install --quiet
# Fail when Brakeman is outdated
bundle exec brakeman -q --no-pager --ensure-latest
bundle exec rubocop .
bundle exec bowndler install -q

bundle exec rspec -f progress
bundle exec cucumber -f progress

./node_modules/karma/bin/karma start spec/javascripts/karma.conf.js --single-run --reporters dots

bundle exec danger pr --verbose --fail-on-errors=true --base=master
