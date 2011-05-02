class UserApp

  def initialize(opts)
    @username = opts[:username]
    @host = opts[:host]
  end

  def create_user_app!
    system "cp -r #{settings.root_dir}/client/uploader.app #{settings.tmp_dir}/#{get_file_path}"
    system "echo \"#{@username}\" > #{settings.tmp_dir}/#{get_file_path}/Contents/Resources/username.name"
    system "echo \"#{@hostname}\" > #{settings.tmp_dir}/#{get_file_path}/Contents/Resources/hostname.name"
    Dir.chdir(settings.tmp_dir) do
      system "tar -cf #{get_archive_path} #{get_file_path}"
      system "rm -r #{get_file_path}"
    end
  end

  def created?
    File.exist?(file)
  end

  def file
    "#{settings.tmp_dir}/#{get_archive_path}"
  end

protected

  def get_file_path
    "#{@username}.app"
  end

  def get_archive_path
    "#{@username}_app.tar"
  end
end