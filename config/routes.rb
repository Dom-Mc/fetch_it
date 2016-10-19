Rails.application.routes.draw do
  resources :orders
  resources :services
  resources :shippers
  resources :recipients
  resources :addresses
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
