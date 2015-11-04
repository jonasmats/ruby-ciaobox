Rails.application.routes.draw do
  namespace :shipping do
    resources :standard, only: :index
    resources :fly, only: :index
  end
end
