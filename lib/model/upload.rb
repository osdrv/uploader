require 'digest/sha1'

class Upload
  include Mongoid::Document
  include Mongoid::Paperclip

  field :file_file_name
  field :file_content_type
  field :file_width, :type => Integer
  field :file_height, :type => Integer
  field :file_type
  field :file_updated_at, :type => DateTime
  field :short_name

  validates_presence_of :file_file_name, :short_name

  has_mongoid_attached_file :file, :path => "#{settings.public_dir}/i/:sharded_id/:short_name", :url => "/i/:sharded_id/:short_name"

  Paperclip.interpolates :sharded_id do |a, s|
    Digest::SHA1.hexdigest(a.instance._id.to_s)[0, 2]
  end

  Paperclip.interpolates :short_name do |a, s|
    a.instance.short_name
  end

  def original_name=(name)
    self.short_name = Base62.to_s(Time.now.to_i) + File.extname(name)
  end

end
