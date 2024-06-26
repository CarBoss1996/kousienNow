# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resource :profile, only: %i[show edit update destroy]
  resources :posts do
    resources :comments, only: %i[create edit destroy], shallow: true
    collection do
      get :like_posts
    end
  end
  resources :user_locations
  resources :seats

  root 'static_pages#top'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
