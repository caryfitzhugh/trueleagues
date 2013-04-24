module OnboardHelper
  SECRET_ONBOARD_KEY = "113cksjdhf937172hdkjhssdfaoier840018cmmzma110fhkjvhurkr"

  def onboard_new_user_path_generator(user, destination, description)
    # user should be 'pending' -- now send them to onboarding
    token = token_for_onboard(user, destination, description)
    destination = Base64.encode64(destination)
    description = Base64.encode64(description)

    onboard_user_url(:token => token, :destination => destination, :description => description, :user_id => user.id)
  end

  def token_for_onboard(user, go_to, description)
    email = user.email
    enc_string = Base64.encode64(email + go_to + description)
    digest = OpenSSL::Digest::Digest.new('sha1')
    Base64.encode64(OpenSSL::HMAC.digest(digest, SECRET_ONBOARD_KEY, enc_string))
  end
end
