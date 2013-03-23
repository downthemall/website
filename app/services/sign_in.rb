require 'net/https'
require 'ostruct'

class SignIn

  def self.find_or_create_user(assertion, host)
    persona = Persona.new(audience: host)
    result = persona.verify_assertion!(assertion)
    if (( user = User.find_by_email(result.email) ))
      user
    else
      User.create!(email: result.email)
    end
  rescue Persona::InvalidResponse
    nil
  end

  class Persona
    class InvalidResponse < RuntimeError; end

    VERIFICATION_SERVER = 'verifier.login.persona.org'
    VERIFICATION_PATH = '/verify'

    attr_reader :verification_server, :verification_path, :audience

    def initialize(args)
      @verification_server = args.fetch(:verification_server, VERIFICATION_SERVER)
      @verification_path = args.fetch(:verification_path, VERIFICATION_PATH)
      @audience = args.fetch(:audience)
    end

    # A successful response looks like the following:
    # {
    #   "status": "okay",
    #   "email": "user@example.com",
    #   "audience": "https://service.example.com:443",
    #   "expires": 1234567890,
    #   "issuer": "persona.mozilla.com"
    # }
    def verify_assertion!(assertion)
        http = Net::HTTP.new(verification_server, 443)
        http.use_ssl = true

        verification = Net::HTTP::Post.new(verification_path)
        verification.set_form_data(assertion: assertion, audience: audience)

        response = http.request(verification)
        raise InvalidResponse, "Unsuccessful response from #{@server}: #{response}" unless response.kind_of? Net::HTTPSuccess
        authentication = OpenStruct.new JSON.parse(response.body)

        # Authentication response is a JSON hash which must contain a 'status'
        # of "okay" or "failure".
        status = authentication.status
        raise InvalidResponse, "Unknown authentication status '#{status}'" unless %w{okay failure}.include? status

        # An unsuccessful authentication response should contain a reason string.
        raise InvalidResponse, "Assertion failure: #{authentication.reason}" unless status == "okay"

        auth_audience = authentication.audience
        raise InvalidResponse, "Persona assertion audience '#{auth_audience}' does not match verifier audience '#{audience}'" unless auth_audience == audience

        expires = authentication.expires && Time.at(authentication.expires.to_i/1000.0)
        raise InvalidResponse, "Persona assertion expired at #{expires}" if expires && expires < Time.now

        authentication
    end
  end
end
