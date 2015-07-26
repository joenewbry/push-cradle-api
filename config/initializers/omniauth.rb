Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.secrets.client_id, Rails.application.secrets.client_secret, {
    scope: ['email', 'https://www.googleapis.com/auth/gmail.readonly','https://www.googleapis.com/auth/pubsub'],
    access_type: 'offline'}
end
