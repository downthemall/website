class User < ActiveRecord::Base
  validates :email, presence: true
  validates :email, format: /@/, uniqueness: true

  validates :password, length: { minimum: 6 }, if: :new_record?
  validates :password, presence: true, if: :new_record?

  attr_accessor :password

  def find_by_email(email)
    where(email: email).first
  end

  def admin?
    !! self.admin
  end

end
