Rails.application.routes.draw do
  get 'events/index'
  devise_for :users, controllers: {
    registrations: "users/registrations",
  }
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end
  resources :tasks, only: [:index, :create, :show, :update, :destroy]
  patch '/posts/:id', to: 'posts#update'
  post '/posts/guest_sign_in', to: 'posts#new_guest'
  root 'posts#index'
end