Rails.application.routes.draw do
  root 'home#index'

  get 'profile/index/:user_id', to: 'profile#index', as: 'profile' 
  get 'dashboard', to: 'dashboard#index', as: 'dashboard'

  resources :posts do
    resources :comments do
      patch :approve, on: :member
    end
  end
  
  devise_for :users 

  resources :users
end
