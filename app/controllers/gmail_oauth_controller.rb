require 'google/api_client/client_secrets'

class GmailOauthController < ApplicationController

  def index
    if not cookies.encrypted[:gmail_oauth_token]
      client_secrets = nil
      if Rails.env.development?
        client_secrets = Google::APIClient::ClientSecrets.load('local_client_secret.json')
      end
      if Rails.env.production?
        client_secrets = Google::APIClient::ClientSecrets.load('client_secret.json')
      end

      auth_client = client_secrets.to_authorization
      auth_client.update!(
        :scope => 'https://www.googleapis.com/auth/drive.metadata.readonly',
        :redirect_uri => url_for(controller: 'gmail_oauth', action: 'callback'))

      auth_uri = auth_client.authorization_uri.to_s
      redirect_to auth_uri
    else 
      @auth_token = cookies.encrypted[:gmail_oauth_token]
    end
  end

  def callback
    cookies.encrypted[:gmail_oauth_token] = params[:code]
    redirect_to action: "index"
  end
end
