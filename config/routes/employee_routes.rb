Rails.application.routes.draw do
  namespace :admin do
    namespace :employee do
      root to: 'home#index'

      resources :users
      resources :articles
    end
  end
end
