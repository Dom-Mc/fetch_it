Rails.application.routes.draw do
  root 'static_pages#home'

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

  # TODO: check resources
  # resources :orders, only: [:index, :new, :create, :show]

  resources :services, only: [:index, :new, :create, :show, :edit, :update]

  resources :accounts, path: :account, except: :destroy do
    resources :orders, only: [:index, :new, :create, :show]
  end
  # resources :shippers
  # resources :recipients
  # resources :addresses
end
