# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',registrations: 'users/registrations' }, omniauth_providers: [:google_oauth2]
  resource :profile, only: %i[show edit update destroy]
  resources :posts do
    resources :comments, only: %i[create edit destroy], shallow: true
    collection do
      get :like_posts
    end
  end
  resources :like_posts, only: %i[create destroy]
  resources :user_locations
  resources :deactivations, only: %i[new create]
  namespace :api do
    resources :seats, only: [:index]
  end
  resources :matches do
    collection do
      get :match_list
      get :match_calendar
      post :add_to_schedule
      get 'show_month/:month', to: 'matches#show_month', as: :show_month
    end
  end
  get 'calendar/:month', to: 'calendars#show_month', as: :month_calendar
  root 'static_pages#top'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  get 'terms_of_service', to: 'static_pages#terms_of_service'
  namespace :admin do
    root to: 'dashboards#index'
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    resources :users
    resources :posts
    resources :matches do
      collection do
        get 'show_month/:month', to: 'matches#show_month', as: :month
      end
    end
    resources :events
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
