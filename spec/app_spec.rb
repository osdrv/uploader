# encoding: utf-8

require 'spec_helper'

describe 'приложение' do

  include Rack::Test::Methods

  def app
    @app ||= Sinatra::Application
  end

  describe 'основные страницы' do

    it 'должен возвращать 200й ответ при запросе главной страницы' do
      get '/'
      last_response.should be_ok
      last_response.content_type.should eq 'text/html;charset=utf-8'
      last_response.content_length.should > 0
    end

    it 'должен отдавать 200й ответ при запросе страницы с формой' do
      get '/new'
      last_response.should be_ok
      last_response.content_type.should eq 'text/html;charset=utf-8'
      last_response.content_length.should > 0
    end

  end

  describe 'при неправильном запросе на создание приложения' do

    it 'должен возвращать 400й ответ при попытке создания приложения без имени пользователя' do
      post '/new'
      last_response.status.should eq 400
      last_response.body.should eq 'Username given is empty.'
    end

    it 'должен возвращать 406й ответ если имя пользователя сожержит недопустимые символы' do
      ['asdf asdf', 'helloshell#ls-la', 'ls -la'].each do |username|
        post '/new', :username => username
        last_response.status.should eq 406
        last_response.body.should eq 'Username given should contains digits and/or latin characters only.'
      end
    end
  end

  describe 'при валидном запросе на создание приложения' do

    let(:username) { "test" }
    let(:file_path) { File.join(File.dirname(__FILE__), '..', 'tmp', "#{username}_app.tar") }

    before(:each) do
      post '/new', :username => username
    end

    after(:each) do
      File.unlink(file_path) if File.exist?(file_path)
    end

    it 'дожен возвращать 200й ответ' do
      last_response.should be_ok
    end

    it 'должен возвращать приложение в виде tar-архива' do
      last_response.content_type.should eq 'application/x-tar'
      last_response.content_length.should > 100000
    end

    it 'должен создавать приложение в папке tmp/' do
      File.exist?(file_path).should be_true
    end
  end

end