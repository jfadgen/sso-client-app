module WelcomeHelper
  def sign_out_url
    URI("#{ENV["SSO_PROVIDER_URL"]}accounts/sign_out").to_s
  end
end
