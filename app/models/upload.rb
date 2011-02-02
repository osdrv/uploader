class Upload
  include Mongoid::Document
  include Mongoid::Paperclip

  field :file_file_name
  field :file_content_type
  field :file_width, :type => Integer
  field :file_height, :type => Integer
  field :file_type
  field :file_updated_at, :type => DateTime

  has_attached_file :file, :path => ":rails_root/public/i/:id/:filename", :url => "/i/:id/:filename"
end
