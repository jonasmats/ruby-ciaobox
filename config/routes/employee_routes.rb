Rails.application.routes.draw do
  namespace :employee do
    root to: 'home#index'
  end
end
