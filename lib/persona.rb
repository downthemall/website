require 'ostruct'
require 'json'

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
    response = request_assertion(assertion)

    status = response.status
    raise InvalidResponse, "Assertion failure: #{response.reason}" unless status == "okay"

    auth_audience = response.audience
    raise InvalidResponse, "Persona assertion audience '#{auth_audience}' does not match verifier audience '#{audience}'" unless auth_audience == audience

    expires = response.expires && Time.at(response.expires.to_i / 1000.0)
    raise InvalidResponse, "Persona assertion expired at #{expires}" if expires && expires < Time.now

    response
  end

  private

  def request_assertion(assertion)
    http = Net::HTTP.new(verification_server, 443)
    http.use_ssl = true

    verification = Net::HTTP::Post.new(verification_path)
    verification.set_form_data(assertion: assertion, audience: audience)

    response = http.request(verification)
    raise InvalidResponse, "Unsuccessful response: #{response}" unless response.kind_of? Net::HTTPSuccess

    OpenStruct.new JSON.parse(response.body)
  end
end

