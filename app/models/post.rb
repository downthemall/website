class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  validates :title, :posted_at, :content, :author, presence: true

  scope :published, -> { where("posted_at < ?", Time.now) }
  default_scope order("posted_at DESC")

  def self.count_per_year
    reorder('year DESC').select("date_trunc('year', posted_at) as year, count(*) as count").group("date_trunc('year', posted_at)")
  end
end

