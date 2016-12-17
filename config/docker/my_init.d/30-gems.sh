#!/bin/bash

cd /app

gem install bundler

RACK_ENV=production bundle install --deployment --without development test
