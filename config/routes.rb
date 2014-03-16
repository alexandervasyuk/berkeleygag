Berkeleygag::Application.routes.draw do
  root to:"home#index"

  get "signup", to:"users#new"
  get "signin", to:"sessions#new"
  get "signout", to:"sessions#destroy"

  resources :users
  resources :sessions
end
