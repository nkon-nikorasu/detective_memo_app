Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
  root "start_pages#top"
  get 'privacy', to: 'start_pages#privacy'
  get 'terms', to: 'start_pages#terms'
  resources :incidents do
    resources :incident_times, only: %i[ index create edit update destroy ] do
      member do
        get :move_higher
        get :move_lower
      end
    end
    resources :characters, only: %I[ index create edit update destroy]
    resources :memos, only: %I[ index create edit update destroy]
  end
end
