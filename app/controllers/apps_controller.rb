class AppsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def create
    username = params[:username]
    hostname = request.host_with_port
    Dir.chdir(Rails.root.to_s) do
      system "echo \"#{username}\" > client/uploader.app/Contents/Resources/username.name"
      system "echo \"#{hostname}\" > client/uploader.app/Contents/Resources/hostname.name"
      system "tar -cf #{username}_app.tar client/uploader.app/"
      system "rm client/uploader.app/Contents/Resources/username.name"
      system "rm client/uploader.app/Contents/Resources/hostname.name"
      send_file "#{Rails.root.to_s}/#{username}_app.tar", :filename => "bundle.tar", :type => 'application/x-tar'
    end
  end
end
