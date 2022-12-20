Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :events
  resources :participations
  # Defines the root path route ("/")
  get 'static_pages/secret'

  root 'events#index'
end
