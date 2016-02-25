Rails.application.routes.draw do
  namespace :shipping do
    namespace :schedule do
      resources :collection, only: [:show, :update]
      resources :delivery, only: [:create, :show, :update]
    end

    resources :standard, only: [:show, :update]
    resources :fly, only: [:show, :update]
  end
end
