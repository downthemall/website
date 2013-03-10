class ImageAssetsController < Controller
  post :create, map: '/image-assets/upload' do
    file = UploadedFile.new(params[:file])
    @image_asset = ImageAsset.create!(image: file)
    JSON.dump(filename: @image_asset.image.url(:original, false))
  end
end

Downthemall.controller :image_assets do
  ImageAssetsController.install_routes!(self)
end

