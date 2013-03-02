require 'bcrypt'

class Authentication
  class Fail < RuntimeError; end

  module Helpers
    def current_user
      User.find(session[:user_id]) if session[:user_id]
    end

    def require_non_logged_user!
      if current_user
        flash[:alert] = I18n.t('authentication.already_signed_in')
        redirect url(:index)
      end
    end

    def require_logged_user!
      unless current_user
        flash[:alert] = I18n.t('authentication.must_be_signed_in')
        redirect url(:index)
      end
    end
  end

  def self.authenticate!(email, unencrypted_password)
    user = User.find_by_email(email) or raise Fail
    if check_digest(unencrypted_password, user.password_digest)
      user
    else
      raise Fail
    end
  end

  def self.create_user(email, unencrypted_password)
    User.new.tap do |user|
      user.email = email
      user.password = unencrypted_password
      user.password_digest = digest(unencrypted_password)
    end
  end

  def self.check_digest(password, digest)
    unless digest.blank?
      BCrypt::Password.new(digest) == password
    end
  end

  def self.digest(password)
    unless password.blank?
      BCrypt::Password.create(password)
    end
  end
end

