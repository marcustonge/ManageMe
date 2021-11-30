require 'sidekiq/web'

Rails.application.routes.draw do
  resources :events do
    resources :tasks
  end

  devise_for :users
  get 'active-events', to: "events#active_events"
  get 'contact', to: 'home#contact'
  get 'about', to: 'home#about'
  post 'request_contact', to: 'home#request_contact'


  #Creates a function called admin_destroy_user that is used in the admin panel to delete the selected user.
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user
  resources :users

  root to: 'home#index'
  resources :users, only: [:index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
