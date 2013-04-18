module OnboardHelper
  SECRET_ONBOARD_KEY = "113cksjdhf937172hdkjhssdfaoier840018cmmzma110fhkjvhurkr"

  def token_for_onboard(email, go_to)
    enc_string = Base64.encode64(email + go_to)
    digest = OpenSSL::Digest::Digest.new('sha1')
    Base64.encode64(OpenSSL::HMAC.digest(digest, SECRET_ONBOARD_KEY, enc_string))
  end

  def verify_token_for_onboard_before_signup(token, email, go_to)
    token == token_for_onboard(email, go_to)
  end
end
