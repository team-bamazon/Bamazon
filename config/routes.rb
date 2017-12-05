Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root "products#index"
  # resources :products, [:index]
  resources :users, only: [:index, :edit] do
    get  'user_info'
    get  'edit_name'
    get  'edit_email'
    get  'new_phone_number'
  end
end
