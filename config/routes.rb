Rails.application.routes.draw do
  root "home#show"
  resources :posts
  get 'settings/account'
  post 'settings/account'
  get 'settings/password'
  post 'settings/password'
  # resource :settings, only: [:edit]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
