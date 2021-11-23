require 'sidekiq/web'

Rails.application.routes.draw do
  resources :events do
    resources :tasks
  end
  devise_for :users
  get 'active-events', to: "events#active_events"
  get 'contact', to: 'home#contact'
  post 'request_contact', to: 'home#request_contact'
  
  root to: 'home#index'
  resources :users, only: [:index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
