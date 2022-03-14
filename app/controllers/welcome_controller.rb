class WelcomeController < ApplicationController
  before_action :verify_access_key
  before_action :authenticate

  def index
  end

  def sign_out
    session[:access_key] = nil
    sign_out_url = URI("#{ENV["SSO_PROVIDER_URL"]}accounts/sign_out").to_s
    redirect_to accounts_url, allow_other_host: true
  end

  private

  def verify_access_key
    if params[:access_key]
      # TODO Verfication step.
      session[:access_key] = params[:access_key]
    end
  end

  def authenticate
    Rails.logger.info "~~ authenticate."
    if session[:access_key].present?
      Rails.logger.info "~~ authenticate: #{session[:access_key]}"
    else
      Rails.logger.info "~~ authenticate: route to login."
      redirect_to accounts_url, allow_other_host: true
    end
  end

  def accounts_url(params = {})
    uri = URI(ENV["SSO_PROVIDER_URL"])
    uri.query = params.merge(redirect_url: request.original_url).to_query
    uri.to_s
  end
end
