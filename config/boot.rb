require 'rubygems'

ENV['BUNDLE_GEMFILE'] = File.expand_path(File.join(settings.root_dir, "Gemfile"))

require 'bundler/setup'
require 'pathname'
require 'mongoid'
require 'paperclip'
require 'mongoid_paperclip'

gemfile = File.expand_path('../../Gemfile', __FILE__)

begin
  ENV['BUNDLE_GEMFILE'] = gemfile
  require 'bundler'
  Bundler.setup
rescue Bundler::GemNotFound => e
  STDERR.puts e.message
  STDERR.puts "Try running `bundle install`."
  exit!
end if File.exist?(gemfile)

Mongoid.load!(File.join(settings.config_dir, 'mongoid.yml'))

$:.unshift(settings.lib_dir)

Dir[settings.lib_dir + '/*.rb'].each { |file| require file }
Dir[settings.lib_dir + '/model/*.rb'].each { |file| require file }
