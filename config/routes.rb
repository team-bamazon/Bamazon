Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root "products#index"
  # resources :products, [:index]
  resources :users, only: [:index, :edit] do
    resources :payment_informations, only: [:index, :create, :delete, :edit, :update]
  end
end
