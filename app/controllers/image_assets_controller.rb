class ImageAssetsController < ApplicationController
  respond_to :json

  def create
    file = UploadedFile.new(params[:file])
    @image_asset = ImageAsset.create!(image: file)
    response = { filename: @image_asset.image.url(:original, false) }
    respond_with response
  end
end

