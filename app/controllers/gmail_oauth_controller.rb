require 'google/api_client/client_secrets'
require 'google/apis/pubsub_v1beta2.rb'
require 'google/apis/gmail_v1.rb'
require 'google/apis/drive_v2'

class GmailOauthController < ApplicationController

  # gonna get an auth token
  # then we get use that to get an access token
  # then we can make requests
  def index
    byebug
    if not session[:credentials]
      redirect_to action: "callback"
    else
      client_opts = JSON.parse(session[:credentials])
      client_opts.symbolize_keys!
      client_opts[:redirect_uri] = Addressable::URI.new(client_opts[:redirect_uri].symbolize_keys!)
      auth_client = Signet::OAuth2::Client.new(client_opts)
      service = Google::Apis::GmailV1::GmailService.new
      service.list_user_messages(auth_client.access_token)
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
    byebug
    auth_client.update!(
      :scope => 'https://www.googleapis.com/auth/gmail.readonly https://www.googleapis.com/auth/pubsub https://www.googleapis.com/auth/drive.metadata.readonly',
      :redirect_uri => url_for(controller: 'gmail_oauth', action: 'callback'))

    # If no token we should grab token
    if not params[:code]
      auth_uri = auth_client.authorization_uri.to_s
      redirect_to auth_uri

    # Exchange token
    else
      auth_client.code = params[:code] 
      auth_client.fetch_access_token!
      byebug
      session[:credentials] = auth_client.to_json
      redirect_to action: "index"
    end
  end

end
