Rails.application.routes.draw do
  resources :faqs, only: :index
  resources :contacts, only: :index
  resources :abouts, only: :index
  resources :prices, only: :index
end
