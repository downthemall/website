class Revision < ActiveRecord::Base
  belongs_to :article
  belongs_to :author, class_name: "User"

  validates :article, :locale, :title, :content, :author, presence: true

  default_scope order('created_at DESC')

  scope :approved, ->{ where(approved: true) }
  scope :not_approved, -> { where("approved <> ?", true) }
  scope :with_locale, ->(locale) { where(locale: locale) }
  scope :with_author, ->(author) { where(author_id: author) }

  STATUS_APPROVED = :approved
  STATUS_SKIPPED = :skipped
  STATUS_PUBLIC = :public
  STATUS_PENDING = :pending

  def self.pending
    approved_time = <<-RAW
      SELECT COALESCE(MAX(created_at), DATE '1970-01-01') FROM revisions i WHERE i.approved = ? AND i.locale = v.locale AND i.article_id = v.article_id
    RAW
    query = <<-RAW
      SELECT DISTINCT ON (article_id, locale) v.* AS approved_time FROM revisions v WHERE (v.approved IS NULL OR v.approved = ?) AND (#{approved_time}) < created_at ORDER BY article_id, locale, created_at DESC
    RAW
    Revision.find_by_sql([query, false, true])
  end

  def latest_revision
    article.latest_revision(locale)
  end

  def to_param
    "#{id}-#{title.parameterize}"
  end

  def approve!
    self.approved = true
    save!
  end

  def self.build(locale, user, params)
    Revision.new(
      locale: locale,
      author: user,
      title: params[:title],
      content: params[:content],
      article: Article.new(category: params[:category])
    )
  end

  def build_updated(user, params)
    if author == user && !approved
      self.title = params[:title]
      self.content = params[:content]
      self
    else
      Revision.new(
        locale: self.locale,
        author: user,
        title: params[:title],
        content: params[:content],
        article: self.article
      )
    end
  end

  def destroy!
    art = self.article
    self.destroy
    art.reload
    art.destroy if art.revisions.count == 0
  end

  def locale
    if (( s = read_attribute(:locale) ))
      s.to_sym
    else
      nil
    end
  end

  def status
    public_revision = article.public_revision(locale)
    if public_revision == self
      STATUS_PUBLIC
    elsif !public_revision || public_revision.created_at < created_at
      STATUS_PENDING
    else
      approved ? STATUS_APPROVED : STATUS_SKIPPED
    end
  end

end
