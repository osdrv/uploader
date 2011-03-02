Paperclip.interpolates :partial_id do |a, s|
  a.instance._id.to_s[0, 5]
end

class Upload
  include Mongoid::Document
  include Mongoid::Paperclip

  field :file_file_name
  field :file_content_type
  field :file_width, :type => Integer
  field :file_height, :type => Integer
  field :file_type
  field :file_updated_at, :type => DateTime

  has_mongoid_attached_file :file, :path => ":rails_root/public/i/:partial_id/:filename", :url => "/i/:partial_id/:filename"
end
