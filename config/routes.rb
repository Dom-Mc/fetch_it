Rails.application.routes.draw do
  root 'static_pages#home'

  # resources :orders
  # resources :services
  # resources :shippers
  # resources :recipients
  # resources :addresses
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" },
                     skip: :registrations,
                     :path => '',
                     :path_names => { sign_in: "login", sign_out: "logout", sign_up: "signup" }

  devise_scope :user do
    resource :registration,
      only: [:new, :create, :edit, :update],
      path: '',
      path_names: { new: 'signup' },
      controller: 'devise/registrations',
      as: :user_registration do
        get :cancel
      end
  end

  get '/profile', to: 'users#profile', as: 'profile'
  resources :orders, only: [:index, :new, :create]
end
