# encoding: utf-8

require 'spec_helper'

describe UploadsController do
  describe 'при запросе несуществующей картинки' do
    it 'должен отдавать 422й ответ' do
      get :show, :id => 'something'
      response.status.should eq 422
    end
  end

  describe 'при загрузке изображения' do
    let(:root) { File.join(File.dirname(__FILE__), '..', '..') }
    let(:upload_file) { File.join(root, 'tmp', '4pcbr012535.png') }

    before(:each) do
      post :create, :upload => { :file => File.new(upload_file) }
    end

    after(:each) do
      system("rm -rf #{root}/public/i/*")
    end

    it 'должен отдавать 200й ответ' do
      response.status.should eq 200
    end

    it 'названия файлов до и после загрузки должны совпадать' do
      start_basename = File.basename(upload_file)
      new_file_path = response.body.to_s
      final_basename = File.basename(new_file_path)
      start_basename.should eq final_basename
      uploaded_file_path = File.join(root, 'public', new_file_path)
    end

    it 'файл должен сохраняться на диске' do
      uploaded_file_path = File.join(root, 'public', response.body.to_s)
      File.exist?(uploaded_file_path).should be_true
    end
  end
end
