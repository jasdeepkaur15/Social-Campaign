Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :socials
  root to: "socials#index"
   devise_for :users, :controllers => { sessions: 'users/sessions', registrations: 'users/registrations', omniauth_callbacks: "users/omniauth_callbacks", confirmations: "users/confirmations" }
as :user do
   get 'login' => 'sessions#new', :as => "login"
   get 'signup' => 'registrations#new', :as => "signup"  
   get 'signout' => 'devise/sessions#destroy', :as => "signout"
end
end
