#!/bin/bash -l

set -e -x

export RAILS_ENV=build
export BUNDLE_WITHOUT="development:test"

bundle install
bundle exec bowndler install

gem build wpcc.gemspec
