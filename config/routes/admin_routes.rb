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
  end
end
