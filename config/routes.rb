Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root "products#index"
  # resources :products, [:index]
  resources :users, only: [:index, :edit]
  resources :products, only: [:show]
  resources :cart, only: [:new, :show, :edit, :create, :destoy]
end
