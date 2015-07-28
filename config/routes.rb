Rails.application.routes.draw do

  root to: 'users#new'
  resources :sessions, only: :index
  resources :users
  get "/auth/:provider/callback" => 'sessions#create'

end
