class AppsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def create
    username = params[:username]
    hostname = request.host_with_port
    Dir.chdir(Rails.root.to_s) do
      system "echo \"#{username}\" > client/auc_bundle.app/Contents/Resources/username.name"
      system "echo \"#{hostname}\" > client/auc_bundle.app/Contents/Resources/hostname.name"
      system "tar -cvzpf #{username}_app.tar.gz client/auc_bundle.app/"
      system "rm client/auc_bundle.app/Contents/Resources/username.name"
      system "rm client/auc_bundle.app/Contents/Resources/hostname.name"
      send_file "#{Rails.root.to_s}/#{username}_app.tar", :filename => "bundle.tar"
    end
  end
end
