Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :events
  resources :participations
  resources :users, only: [ :show, :edit, :update ]
  # Defines the root path route ("/")
  get 'static_pages/secret'
  root 'events#index'
  get '/checkout', to: 'checkouts#show'
  # scope '/checkout' do
  #   post 'create', to: 'checkout#create', as: 'checkout_create'
  #   get 'success', to: 'checkout#success', as: 'checkout_success'
  #   get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  # end
end
