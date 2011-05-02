set :root_dir, File.expand_path(File.join(File.dirname(__FILE__), '..'))
set :config_dir, File.dirname(__FILE__)
set :public_dir, File.join(settings.root_dir, 'public')
set :tmp_dir, File.join(settings.root_dir, 'tmp')
set :lib_dir, File.join(settings.root_dir, 'lib')

Dir["#{settings.root_dir}/spec/support/**/*.rb"].each {|f| require f}

ENV ||= {}
RACK_ENV ||= :development
ENV['RACK_ENV'] ||= RACK_ENV.to_s
