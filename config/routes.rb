# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }, omniauth_providers: [:facebook]
  resource :profile, only: %i[show edit update destroy]
  resources :posts do
    resources :comments, only: %i[create edit destroy], shallow: true
    collection do
      get :like_posts
    end
  end
  resources :like_posts, only: %i[create destroy]
  resources :user_locations
  resources :seats
  resources :deactivations, only: %i[new create]

  root 'static_pages#top'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  get 'terms_of_service', to: 'static_pages#terms_of_service'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
