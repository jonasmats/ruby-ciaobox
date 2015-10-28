Rails.application.routes.draw do
  namespace :admin do
    root to: 'home#index'

    namespace :faq do
      resources :categories
    end

    resources :faqs
    resources :profile, except: [:destroy, :new, :create]
  end
end
