class AppsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def create
    username = params[:username]
    system "echo \"#{username}\" > client/auc_bundle.app/Contents/Resources/username.name"
    system "tar -cf #{username}_app.tar client/auc_bundle.app/"
    system "rm client/auc_bundle.app/Contents/Resources/username.name"
    send_file "#{username}_app.tar", :filename => "bundle.tar"
  end
end
