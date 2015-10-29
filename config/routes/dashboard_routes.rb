Rails.application.routes.draw do
  namespace :dashboard do
    root to: 'home#index'
  end
end
