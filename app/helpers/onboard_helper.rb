module OnboardHelper
  SECRET_ONBOARD_KEY = "113cksjdhf937172hdkjhssdfaoier840018cmmzma110fhkjvhurkr"

  def onboard_new_account_path_generator(account, destination, description, data= {})
    # account should be 'pending' -- now send them to onboarding
    token = token_for_onboard(account, destination, description)
    destination = Base64.encode64(destination)
    description = Base64.encode64(description)

    onboard_account_url(data.merge(:token => token, :destination => destination, :description => description, :account_id => account.id))
  end

  def token_for_onboard(account, go_to, description)
    email = account.email
    enc_string = Base64.encode64(email + go_to + description)
    digest = OpenSSL::Digest::Digest.new('sha1')
    Base64.encode64(OpenSSL::HMAC.digest(digest, SECRET_ONBOARD_KEY, enc_string))
  end
end
