Rails.application.routes.draw do
  namespace :shipping do
    resources :standard, only: :show
    resources :fly, only: :show
  end
end
