Rails.application.routes.draw do
  namespace :detrack do
    resources :collection_notify, only: [:create]
    resources :delivery_notify, only: [:create]
  end
end
