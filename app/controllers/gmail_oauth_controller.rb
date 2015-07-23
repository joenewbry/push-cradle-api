require 'google/api_client/client_secrets'
#require 'google/apis/drive_v2'

class GmailOauthController < ApplicationController


  def index
    client_secrets = Google::APIClient::ClientSecrets.load('client_secret.json')
    auth_client = client_secrets.to_authorization
    auth_client.update!(
      :scope => 'https://www.googleapis.com/auth/drive.metadata.readonly',
      :redirect_uri => url_for(controller: 'oauth', action: 'index'))
    if request['code'] == nil
      auth_uri = auth_client.authorization_uri.to_s
      redirect_to auth_uri
    else
      auth_client.code = request['code']
      auth_client.fetch_access_token!
      auth_client.client_secret = nil
      session[:credentials] = auth_client.to_json
      redirect_to('/')
    end
  end
end
