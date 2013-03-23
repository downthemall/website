class User < ActiveRecord::Base
  validates :email, presence: true
  validates :email, format: /@/, uniqueness: true

  scope :admins, where(admin: true)

  def find_by_email(email)
    where(email: email).first
  end

  def admin?
    !! self.admin
  end
end
