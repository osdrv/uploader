require 'sinatra'

set :environment, ENV['RACK_ENV']
disable :run

require File.join(File.dirname(__FILE__), 'app')

run Sinatra::Application
