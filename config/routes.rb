Rails.application.routes.draw do
  resources :notifications, only: [:index]
  devise_for :users
  get 'rooms/index'
  resources :rooms do
    resources :messages
  end
  resources :users
  namespace :api, defaults: { format: :json } do
    resources :rooms, only: [:index]
    resources :messages, only: [:create]
  end
  root 'rooms#index'
end
