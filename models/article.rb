class Article < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  validates :title, :posted_at, :content, :author, presence: true

  scope :published, -> { where("posted_at < ?", Time.now) }
  default_scope order("posted_at DESC")
end
