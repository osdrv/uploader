# encoding: utf-8

require 'spec_helper'

describe 'загрузка изображений' do

  include Rack::Test::Methods

  def app
    @app ||= Sinatra::Application
  end

  describe 'при запросе несуществующей картинки' do
    it 'должен отдавать 422й ответ' do
      get '/i/asdfasdf.png'
      last_response.status.should eq 422
    end
  end

  describe 'при загрузке изображения' do
    let(:root) { File.join(File.dirname(__FILE__), '..') }
    let(:upload_file) { File.expand_path(File.join(root, 'tmp', '4pcbr012535.png')) }

    before(:each) do
      post '/uploads', :upload => { :file => Rack::Test::UploadedFile.new(upload_file) }
    end

    after(:each) do
      system("rm -rf #{root}/public/i/*")
    end

    it 'должен отдавать 200й ответ' do
      last_response.status.should eq 200
    end

    it 'названия файлов до и после загрузки должны совпадать' do
      start_basename = File.basename(upload_file)
      new_file_path = last_response.body.to_s
      final_basename = Base62.to_s(Time.now.to_i) + File.extname(start_basename)
      File.basename(new_file_path).should eq final_basename
      uploaded_file_path = File.join(root, 'public', new_file_path)
    end

    it 'файл должен сохраняться на диске' do
      uploaded_file_path = File.join(root, 'public', last_response.body.to_s)
      File.exist?(uploaded_file_path).should be_true
    end

    it 'должна создаваться запись в базе' do
      filename = last_response.body.to_s
      Upload.last.short_name.should eq File.basename(filename)
    end
  end
end