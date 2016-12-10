Rails.application.routes.draw do
  root to: "subs#index"
  resources :users
  resource :session
  resources :subs, except: [:destroy]
  resources :posts do
    member do
      post "upvote"
      post "downvote"
    end
    resources :comments, only: [:new, :create]
  end
  resources :comments, only: [:show, :create]
end
