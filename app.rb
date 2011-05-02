require 'erb'
require 'sinatra'

require File.join(File.dirname(__FILE__), 'config', 'config.rb')
require File.join(File.dirname(__FILE__), 'config', 'boot.rb')

Bundler.require(:default, RACK_ENV) if defined?(Bundler)

set :erb, :layout_egine => :erb, :layout => :layout
set :views, settings.root_dir + '/views'

get '/' do
  erb :index
end

get '/new' do
  erb :form
end

post '/new' do
  username = params[:username]
  host = request.host
  host += [80, 8080].include?(request.port) ? '' : ":#{request.port}"
  halt 400, 'Username given is empty.' if username.nil?
  halt 406, 'Username given should contains digits and/or latin characters only.' if !username.to_s.match(/^[\d\w]+$/)
  begin
    app = UserApp.new(:username => username, :host => host)
    app.create_user_app!
    raise 'fuck...' if !app.created?
    send_file app.file, :type => 'application/x-tar'
  rescue => e
    halt 417, 'Application requested could not being created.'
  end
end

get '/i/*' do
  halt 422, "The snapshot is not ready yet or was removed permanently."
end

post '/uploads' do
  file_data = params[:upload]['file']
  upload = Upload.create!(:file => File.new(file_data[:tempfile]), :original_name => file_data[:filename])
  [200, {}, upload.file.url(:original, false)]
end
