class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User"

  validates :author, presence: true
  validates :content, presence: true
  validates :title, presence: true

end
