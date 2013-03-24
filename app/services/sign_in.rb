require 'net/https'
require 'ostruct'

class SignIn

  def self.find_or_create_user(assertion, host)
    result = Persona.new(audience: host).verify_assertion!(assertion)
    User.find_or_create_by_email(result.email)
  rescue Persona::InvalidResponse
    nil
  end

end
