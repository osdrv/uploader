class UploadsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def create
    @upload = Upload.create(params[:upload])
    Rails.logger.debug(@upload.file.url)
    render :text => @upload.file.url
  end

  def show
    render :text => "Loading"
  end
end
