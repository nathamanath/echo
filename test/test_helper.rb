ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'
require 'pry'
require 'json'

require File.expand_path '../../app.rb', __FILE__

