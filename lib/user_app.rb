class UserApp

  def initialize(opts)
    @username = opts[:username]
    @host = opts[:host]
  end

  def create_user_app!
    system "cp -r #{settings.root_dir}/client/uploader.app #{get_file_path}"
    system "echo \"#{@username}\" > #{get_file_path}/Contents/Resources/username.name"
    system "echo \"#{@hostname}\" > #{get_file_path}/Contents/Resources/hostname.name"
    system "tar -cf #{get_archive_path} #{get_file_path}"
    system "rm -r #{get_file_path}"
  end

  def created?
    File.exist?(get_archive_path)
  end

  def file
    File.new(get_archive_path)
  end

protected

  def get_file_path
    "#{settings.tmp_dir}/#{@username}.app"
  end

  def get_archive_path
    "#{settings.tmp_dir}/#{@username}_app.tar"
  end
end