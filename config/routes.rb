Rails.application.routes.draw do
  root "home#show"
  resources :posts
  get 'settings/account'
  post 'settings/account'
  get 'settings/password'
  post 'settings/password'

  get    '/signup',  to: "users/registrations#new"
  post   '/signup',  to: "users/registrations#create"
  get    '/login',   to: "users/sessions#new"
  post   '/login',   to: "users/sessions#create"
  delete '/logout',  to: "users/sessions#destroy"

  # resources 'users/registrations', only: [:new, :create], as: :users
  # resource :settings, only: [:edit]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
