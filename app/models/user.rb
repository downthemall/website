class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :twitter_username

  has_many :comments, :inverse_of => :user

  def is_admin?
    admin == true
  end

  def full_name
    full_name = [first_name, last_name].join(" ")
    full_name.present? ? full_name : "Anonymous"
  end

end
