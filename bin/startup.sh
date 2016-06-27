#!/bin/bash

gem install bundler

RACK_ENV=production bundle install --deployment --without development test

RACK_ENV=production bundle exec rackup -p 80
