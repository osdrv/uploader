# encoding: utf-8

require 'spec_helper'

describe Upload do

  describe 'при сохранении нового файла' do

    let(:root) { File.join(File.dirname(__FILE__), '..', '..') }
    let(:upload_file) { File.join(root, 'tmp', '4pcbr012535.png') }

    it 'должен сохранять сущность upload' do
      upload = Upload.create({ :file => File.new(upload_file) })
      upload.save.should be_true
    end

    it 'должен создавать подпапку на основе id новой сущности' do
      upload = Upload.create({ :file => File.new(upload_file) })
      upload.file_file_name.should eq File.basename(upload_file)
      file_path = upload.file.url(:original, false)
      File.exist?(File.join(root, 'public', file_path)).should be_true
      File.dirname(file_path).should eq "/i/#{upload._id.to_s[0, 5]}"
    end

  end

end
