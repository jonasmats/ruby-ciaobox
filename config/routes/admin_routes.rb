Rails.application.routes.draw do
  namespace :admin do
    root to: 'home#index'

    namespace :faq do
      resources :categories
    end

    resources :faqs
    resources :profile, only: [:index, :edit, :update]
    resources :social_networks
    resources :articles
    resources :static_pages
    resources :passwords, only: [:new, :create]
    resources :roles
    resources :banners
    resources :admins
    resources :users
    resources :import_users, only: [:new, :create]
    resources :import_admins, only: [:new, :create]

    resources :items
    resources :members, controller: 'items', type: 'Member'
    resources :presses, controller: 'items', type: 'Press'
    resources :prices, controller: 'items', type: 'Price'
    resources :privacies, controller: 'items', type: 'Privacy'
    resources :key_points, controller: 'items', type: 'KeyPoint'

    namespace :payment do
      resources :methods
      resources :infors
    end
  end
end
