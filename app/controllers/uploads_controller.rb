class UploadsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def create
    @upload = Upload.create(params[:upload])
    Rails.logger.debug(@upload.file.url(:original, false))
    render :text => @upload.file.url(:original, false)
  end

  def show
    render :text => "Loading"
  end
end
