class AppsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def create
    username = params[:username]
    hostname = request.host_with_port
    system "echo \"#{username}\" > client/auc_bundle.app/Contents/Resources/username.name"
    system "echo \"#{hostname}\" > client/auc_bundle.app/Contents/Resources/hostname.name"
    system "tar -cf #{username}_app.tar client/auc_bundle.app/"
    system "rm client/auc_bundle.app/Contents/Resources/username.name"
    system "rm client/auc_bundle.app/Contents/Resources/hostname.name"
    send_file "#{username}_app.tar", :filename => "bundle.tar"
  end
end
