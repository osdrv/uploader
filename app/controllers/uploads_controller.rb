class UploadsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def create
    @upload = Upload.create(params[:upload])
    Rails.logger.debug(@upload.file.url(:original, false))
    render :text => @upload.file.url(:original, false)
  end

  def show
    render :text => "The snapshot is not ready yet pr was removed permanently.", :status => 422
  end
end
