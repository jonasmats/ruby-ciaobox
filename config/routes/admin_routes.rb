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
    resources :item_members, controller: 'items', type: 'Item::Member'
    resources :item_presses, controller: 'items', type: 'Item::Press'
    resources :item_prices, controller: 'items', type: 'Item::Price'
    resources :item_privacies, controller: 'items', type: 'Item::Privacy'
    resources :item_key_points, controller: 'items', type: 'Item::KeyPoint'

    namespace :payment do
      resources :methods
      resources :infors
    end
  end
end
