Rails.application.routes.draw do
  namespace :shipping do
    resources :standard, only: [:show, :update]
    resources :fly, only: [:show, :update]
  end
end
