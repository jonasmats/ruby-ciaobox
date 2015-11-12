Rails.application.routes.draw do
  namespace :dashboard do
    root to: 'home#index'
    resources :profile, only: [:index, :edit, :update]
  end
end
