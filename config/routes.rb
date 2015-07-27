Rails.application.routes.draw do

  root to: 'home#index'
  resources :sessions, only: :index
  resources :users
  get "/auth/:provider/callback" => 'sessions#create'

end
