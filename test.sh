#!/bin/bash

set -e -x

export RAILS_ENV=test
export BUNDLE_WITHOUT=development

yarn install -q
bundle install --quiet
# Fail when Brakeman is outdated
bundle exec brakeman -q --no-pager --ensure-latest
bundle exec rubocop .
bundle exec bowndler install -q

bundle exec rspec -f progress
bundle exec cucumber -f progress
yarn test
