Rails.application.routes.draw do
  namespace :admin do
    root to: 'home#index'

    namespace :faq do
      resources :categories
    end

    resources :faqs
    resources :profile, except: [:destroy, :new, :create, :show]
    resources :social_networks
    resources :articles
    resources :static_pages
    resources :password, only: [:new, :create]
    resources :roles
    resources :banners
    resources :admins
    resources :users
    resources :import_users, only: [:new, :create]
    resources :import_admins, only: [:new, :create]

    namespace :payment do
      resources :methods
      resources :infors
    end
  end
end
