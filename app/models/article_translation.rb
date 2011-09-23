class ArticleTranslation < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :scoped, :scope => :locale

  belongs_to :article, :inverse_of => :translations

  validates :title, :presence => true
  validates :article, :presence => true

  scope :with_locale, lambda { |locale| where(:locale => locale.to_s) }

  def self.enabled_locales
    %w(en de it fr es nl el pt ar ru zh ja).sort.map(&:to_sym)
  end

end

