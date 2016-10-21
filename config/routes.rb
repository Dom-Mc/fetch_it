Rails.application.routes.draw do
  root 'static_pages#home'

  # resources :orders
  # resources :services
  # resources :shippers
  # resources :recipients
  # resources :addresses

  devise_for :users, skip: :registrations
  devise_scope :user do
    resource :registration,
      only: [:new, :create, :edit, :update],
      path: 'users',
      path_names: { new: 'sign_up' },
      controller: 'devise/registrations',
      as: :user_registration do
        get :cancel
      end
  end

  resources :users do
    resources :orders, only: [:new, :create]
  end

end
