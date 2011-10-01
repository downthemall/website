class ArticleImage < ActiveRecord::Base
  belongs_to :article, :inverse_of => :images
  validates :image, :presence => true
  validates :article, :presence => true

  mount_uploader :image, ArticleImageUploader
end
