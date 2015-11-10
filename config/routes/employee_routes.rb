Rails.application.routes.draw do
  namespace :admin do
    namespace :employee do
      root to: 'home#index'

      resources :users
    end
  end
end
