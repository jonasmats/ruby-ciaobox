Rails.application.routes.draw do
  resources :faqs, only: :index
  resources :contacts, only: :index
  resources :abouts, only: :index
  resources :prices, only: :index
  resources :articles, only: [:index, :show], path: "blogs"
  resources :presses, only: :index
  resources :careers, only: :index

  get 'set_language/en'
  get 'set_language/it'
  get 'set_language/fr'
  get 'set_language/de'
end
