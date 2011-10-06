class Comment < ActiveRecord::Base
  belongs_to :article, :inverse_of => :comments
  belongs_to :user, :inverse_of => :comments

  validates :article, :presence => true
  validates :content, :presence => true

  validate :presence_of_user_or_author

  private

  def presence_of_user_or_author
    if author_name.blank? and author_email.blank? and user.blank?
      errors.add :base, I18n.t("activerecord.errors.models.comment.no_name_or_author_infos")
    end
  end

end
