require 'rubygems'
require 'sinatra'
require 'rspec'
require 'rack/test'
require 'mongoid'

set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

RACK_ENV = :test

require File.join(File.dirname(__FILE__), '..', 'app.rb')
