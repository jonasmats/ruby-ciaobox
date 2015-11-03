Rails.application.routes.draw do
  # devise_for :admins
  devise_for :admins, path: 'admin', controllers: {
    sessions: "admin/auth/sessions",
    confirmations: "admin/auth/confirmations",
    passwords: "admin/auth/passwords",
    unlocks: "admin/auth/unlocks"
  }
  devise_for :users, :controllers => { :omniauth_callbacks => "auth/omniauth_callbacks" }
end
