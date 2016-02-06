Rails.application.routes.draw do
  namespace :admin do
    root to: 'home#index'

    namespace :faq do
      resources :categories
    end

    resources :sys_settings, only: [:index, :update]
    resources :backup_dbs, only: [:index, :update, :create]
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
    resources :log_actions, only: [:index, :show]

    resources :order_items

    resources :items
    resources :item_members, controller: 'items', type: 'Item::Member'
    resources :item_presses, controller: 'items', type: 'Item::Press'
    resources :item_prices, controller: 'items', type: 'Item::Price'
    resources :item_privacies, controller: 'items', type: 'Item::Privacy'
    resources :item_key_points, controller: 'items', type: 'Item::KeyPoint'
    resources :item_abouts, controller: 'items', type: 'Item::About'
    resources :item_how_it_works, controller: 'items', type: 'Item::HowItWork'

    namespace :payment do
      resources :methods
      resources :infors
    end

    resources :gifts
    resources :coupons
    resources :custom_coupons, controller: :coupons
    #resources :custom_gifts, controller: :coupons
    resources :referral_coupons, controller: :coupons
    resources :multiple_coupons, controller: :coupons

    resources :orders
    resources :date_offs, except: :show
  end
end
