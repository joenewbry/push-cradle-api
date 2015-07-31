Rails.application.routes.draw do

  get 'static_pages/success'

  get 'static_pages/failure'

  root to: 'users#new'
  resources :sessions, only: :index
  resources :users
  get "/auth/:provider/callback" => 'sessions#create'

end
