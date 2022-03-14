class WelcomeController < ApplicationController
  before_action :verify_access_key
  before_action :authenticate

  def index
  end

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
      redirect_to accounts_url, { redirect_url: request.original_url }, allow_other_host: true
    end
  end

  private

  def accounts_url(params = {})
    uri = URI(ENV["SSO_PROVIDER_URL"])
    uri.query = params.to_query
    uri.to_s
  end
end
