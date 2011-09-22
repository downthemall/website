class ArticleTranslation < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :scoped, :scope => :locale

  belongs_to :article, :inverse_of => :translations

  validates :title, :presence => true
  validates :article, :presence => true

  scope :with_locale, lambda { |locale| where(:locale => locale.to_s) }
end
