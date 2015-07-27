require 'json'
require 'net/http'

class Token < ActiveRecord::Base
  has_one :user
  def to_params
      {'refresh_token' => refresh_token,
       'client_id' => Rails.application.secrets.client_id,
       'client_secret' => Rails.application.secrets.client_secret,
       'grant_type' => 'refresh_token'}
  end

  def request_token_from_google
    #RestClient.post "https://www.googleapis.com/", self.to_params
    # Initialize HTTP library
    url = URI.parse('https://www.googleapis.com')
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    if Rails.env.production?
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    end

    if Rails.env.development?
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE # You should use VERIFY_PEER in production
    end

    # Make request for tokens
    request = Net::HTTP::Post.new('/oauth2/v3/token')
    request.set_form_data(self.to_params)
    response = http.request(request)
  end

  #
  #   Net::HTTP.start(uri.host, uri.port,
  #     :use_ssl => uri.scheme == 'https') do |http|
  #     request = Net::HTTP::Get.new uri
  #
  #     response = http.request request # Net::HTTPResponse object
  #   end

  def refresh!
    response = request_token_from_google
    data = JSON.parse(response.body)
    byebug
    update_attributes(
    access_token: data['access_token'],
    expires_at: Time.now + (data['expires_in'].to_i).seconds)
  end

  def expired?
    expires_at < Time.now
  end

  def fresh_token
    refresh! if expired?
    access_token
  end

end
