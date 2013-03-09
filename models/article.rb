class Article < ActiveRecord::Base
  validates :category, presence: true
  has_many :revisions, dependent: :destroy

  scope :public, ->(locale) { joins(:revisions).merge(Revision.approved).merge(Revision.with_locale(locale)).uniq }
  scope :in_category, ->(cat) { where(category: cat.code) }

  def latest_revision(locale)
    revisions.with_locale(locale).first
  end

  def public_revision(locale)
    revisions.approved.with_locale(locale).first
  end

  def pending_revisions(locale)
    revisions.with_locale(locale).pending
  end

end
