# encoding: utf-8

require 'spec_helper'

describe AppsController do

  describe 'при запросе заглавной страницы' do
    it 'должен возвращать 200й ответ' do
      get :index
      response.should be_success
    end
  end

  describe 'при запросе страницы с формой' do
    it 'должен отдавать 200й ответ' do
      get :new
      response.should be_success
    end
  end

  describe 'при запросе на создание приложения' do

    let(:username) { "test" }
    let(:file_path) { File.join(File.dirname(__FILE__), '..', '..', "#{username}_app.tar") }

    before(:each) do
      post :create, :username => username
    end

    after(:each) do
      File.unlink(file_path) if File.exist?(file_path)
    end

    it 'дожен возвращать 200й ответ' do
      response.should be_success
    end

    it 'должен возвращать приложение в виде tar-архива' do
      response.content_type.should eq 'application/x-tar'
    end

    it 'должен создавать приложение в папке :root/' do
      File.exist?(file_path).should be_true
    end
  end
end
