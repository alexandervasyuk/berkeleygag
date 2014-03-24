Berkeleygag::Application.routes.draw do
  root to:"home#index"

  resources :users
  resources :sessions
  resources :posts

  get "signup", to:"users#new"
  get "signin", to:"sessions#new"
  get "signout", to:"sessions#destroy"
 
  get "confirm/:token", to:"users#confirm"
  get "access_denied", to:"home#access_denied"


  match "*gibberish", to:"home#not_found"
end
