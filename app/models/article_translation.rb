class ArticleTranslation < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :scoped, :scope => :locale

  belongs_to :article

  validates :slug, :presence => true
  validates :article, :presence => true
end
