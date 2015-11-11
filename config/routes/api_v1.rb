Rails.application.routes.draw do
  api_version(:module => "V1", :path => {:value => "v1"}) do
    resources :zip_codes, only: :create
    resources :newsletters, only: :create
    resources :faqs, only: :index
    resources :social_networks, only: :index
  end
end
