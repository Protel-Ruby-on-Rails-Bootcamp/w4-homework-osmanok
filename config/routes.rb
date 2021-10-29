Rails.application.routes.draw do
  root "home#index"

  get "users/show/:user_id", to: "users#show", as: "user"
  get "dashboard", to: "dashboard#index", as: "dashboard"
  get "feed", to: "users#feed", as: "users_feed"

  resources :posts do
    patch :up, on: :member
    patch :down, on: :member

    resources :comments do
      patch :approve, on: :member
      patch :deny, on: :member
    end
  end

  devise_for :users

  resources :users
  resources :relationships, only: %i[create destroy]
end
