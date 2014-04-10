Berkeleygag::Application.routes.draw do
  root to:"home#index"

  resources :users
  resources :sessions
  resources :posts do
    member {post :vote}
  end

  get "signup", to:"users#new"
  get "signin", to:"sessions#new"
  get "signout", to:"sessions#destroy"
 
  get "confirm/:token", to:"users#confirm"
  get "access_denied", to:"home#access_denied"

  get "haha", to:"home#haha"
  get "meh", to:"home#meh"

  get "about", to:"static_pages#about"
  get "contact", to:"static_pages#contact"
  get "terms", to: "static_pages#terms"


  match "*gibberish", to:"home#not_found"
end
