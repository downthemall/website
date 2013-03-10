class ImageAttachmentsController < Controller

  post :create, map: '/image-attachments/create' do
    throw params[:file]
  end

end

Downthemall.controller :image_attachments do
  ImageAttachmentsController.install_routes!(self)
end


