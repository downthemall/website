class ImageAsset < ActiveRecord::Base
  include Paperclip::Glue

  attr_accessible :image
  has_attached_file :image,
    path: File.expand_path('../../public/system/assets/:id/:style/:filename', __FILE__),
    url: "/system/assets/:id/:style/:filename"

  validates_attachment :image, presence: true,
  content_type: { content_type: [ "image/jpg", "image/png", "image/gif" ] },
  size: { in: 0..1048576 }
end
