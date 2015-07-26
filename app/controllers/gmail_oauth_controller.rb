require 'google/api_client/client_secrets'
require 'google/apis/pubsub_v1beta2.rb'
require 'google/apis/gmail_v1.rb'

class GmailOauthController < ApplicationController

  # gonna get an auth token
  # then we get use that to get an access token
  # then we can make requests
  def index
    if not session[:credentials]
      redirect_to action: "callback"
    else
      client_opts = JSON.parse(session[:credentials])
      auth_client = Signet::OAuth2::Client.new(client_opts)
      service = Google::Apis::GmailV1::GmailService.new
      service.list_user_messages
    end
    
  end

  def callback
    client_secrets = nil
    if Rails.env.development?
      client_secrets = Google::APIClient::ClientSecrets.load('local_client_secret.json')
    end
    if Rails.env.production?
      client_secrets = Google::APIClient::ClientSecrets.load('client_secret.json')
    end

    auth_client = client_secrets.to_authorization
    auth_client.update!(
      :scope => 'https://www.googleapis.com/auth/gmail.readonly https://www.googleapis.com/auth/pubsub',
      :redirect_uri => url_for(controller: 'gmail_oauth', action: 'callback'))

    # If no token we should grab token
    if not params[:code]
      auth_uri = auth_client.authorization_uri.to_s
      redirect_to auth_uri

    # Exchange token
    else
      byebug
      auth_client.code = params[:code] 
      auth_client.fetch_access_token!
      session[:credentials] = auth_client.to_json
      redirect_to action: "index"
    end
  end

end
