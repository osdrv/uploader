# encoding: utf-8

require 'spec_helper'
require 'digest/sha1'

describe 'загрузка изображения' do

  describe 'при сохранении нового файла' do

    let(:root) { File.join(File.dirname(__FILE__), '..', '..') }
    let(:upload_file) { File.join(root, 'tmp', '4pcbr012535.png') }

    it 'должен сохранять сущность upload' do
      upload = Upload.new({ :file => File.new(upload_file), :original_name => File.basename(upload_file) })
      upload.save.should be_true
    end

    it 'должен создавать подпапку на основе id новой сущности' do
      upload = Upload.create({ :file => File.new(upload_file), :original_name => File.basename(upload_file) })
      upload.short_name.should eq (Base62.to_s(Time.now.to_i) + File.extname(upload_file))
      file_path = upload.file.url(:original, false)
      File.exist?(File.join(root, 'public', file_path)).should be_true
      File.dirname(file_path).should eq "/i/#{Digest::SHA1.hexdigest(upload._id.to_s)[0, 2]}"
    end

  end

end
