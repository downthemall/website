class Comment < ActiveRecord::Base
  belongs_to :article

  validates :article, :presence => true
  validates :content, :presence => true

  validate :presence_of_user_or_autor
end
