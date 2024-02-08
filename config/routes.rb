Rails.application.routes.draw do
  root to: 'dashboards#show'
  resources :user_blacklists, param: :userid
  resources :admins, param: :uid
  get '/api/blacklist/:userid', to: 'user_blacklists#isuserblacklisted', as: 'is_user_blacklisted'
  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }
  devise_scope :admin do
    get 'sign_in', to: 'admins/sessions#new', as: :new_admin_session
    get 'sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
  end
end
