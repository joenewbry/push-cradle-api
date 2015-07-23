Rails.application.routes.draw do
  scope module: :api, defaults: { format: 'json' } do
    namespace :v1 do
     resources :locations
    end
  end

  get '/', to: 'home#index'
  get '/google97fdd33a147011f3.html', to: 'home#index'
  get  '/oauth2callback', to: 'gmail_oauth#callback'
  resources :devices
  resources :gmail_oauth

end
