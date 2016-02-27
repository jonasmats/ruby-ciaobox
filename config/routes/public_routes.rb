Rails.application.routes.draw do
  resources :faqs, only: :index
  resources :contacts, only: [:index, :create]
  resources :abouts, only: :index
  resources :prices, only: :index
  resources :articles, only: [:index, :show], path: "blogs"
  resources :presses, only: :index
  resources :careers, only: :index
  resources :terms, only: :index
  resources :privacy, only: :index
  resources :invite, only: [:index, :show]

  get 'set_language/en'
  get 'set_language/it'
  get 'set_language/fr'
  get 'set_language/de'
end
