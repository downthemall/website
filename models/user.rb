class User < ActiveRecord::Base
  validates :email, :password, presence: true
  validates :email, format: /@/, uniqueness: true
  validates :password, length: { minimum: 6 }

  attr_accessor :password

  def find_by_email(email)
    where(email: email).first
  end
end
