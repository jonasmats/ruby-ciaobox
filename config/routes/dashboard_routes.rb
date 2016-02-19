Rails.application.routes.draw do
  namespace :dashboard do
    root to: 'home#index'
    resources :profile, only: [:index, :edit, :update]
    resources :password, only: [:new, :create]
    resources :mystuff, only: [:index]
  end
end
