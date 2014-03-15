Berkeleygag::Application.routes.draw do
  root to:"home#index"

  get "signup", to:"users#new"

  resources :users
end
