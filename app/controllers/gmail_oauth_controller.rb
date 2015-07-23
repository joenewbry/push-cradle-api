require 'google/api_client/client_secrets'

class GmailOauthController < ApplicationController

  # gonna get an auth token
  # then we get use that to get an access token
  # then we can make requests
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
        :scope => 'https://www.googleapis.com/auth/gmail.readonly',
        :redirect_uri => url_for(controller: 'gmail_oauth', action: 'callback'))

      auth_uri = auth_client.authorization_uri.to_s
      redirect_to auth_uri
    else 
      @auth_token = cookies.encrypted[:gmail_oauth_token]
    end
  end

  def callback
    #An error response:

    #  https://oauth2-login-demo.appspot.com/auth?error=access_denied
    #An authorization code response:

      #https://oauth2-login-demo.appspot.com/auth?code=4/P7q7W91a-oMsCeLvIaQm6bTrgtp70
    cookies.encrypted[:gmail_oauth_token] = params[:code]
    redirect_to action: "index"
  end
end
