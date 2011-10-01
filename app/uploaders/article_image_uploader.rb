# encoding: utf-8

class ArticleImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  storage :file

  process :resize_to_fit => [800, 600]

  version :thumb do
    process :resize_to_fill => [115, 70]
  end

  version :medium do
    process :resize_to_fit => [500, 1000]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

 end
