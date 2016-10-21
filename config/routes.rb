Rails.application.routes.draw do
  root 'static_pages#home'

  # resources :orders
  # resources :services
  # resources :shippers
  # resources :recipients
  # resources :addresses

  devise_for :users

  resources :users do
    resources :orders, only: [:new, :create]
  end

end
