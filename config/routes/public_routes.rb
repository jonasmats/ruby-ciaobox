Rails.application.routes.draw do
  resources :faqs, only: :index
end
