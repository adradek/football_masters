Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  root "users#index"

  # Логин по ссылке-секрету
  get "login/:secret" => "sessions#create", as: :login
  delete "logout" => "sessions#destroy", as: :logout

  resources :users, only: %i[index] do
    patch :toggle_shadows, on: :collection
  end
  resources :nations, only: %i[index show]
  resources :matches, only: %i[index]
  resources :rules, only: %i[index]

  namespace :admin do
    resources :users, only: %i[index new create edit update] do
      resources :squads, only: %i[index new create]
      resources :squad_checks, only: %i[create]
    end

    resources :matches, only: %i[index new create edit update] do
      get :pending, on: :collection
      resources :bonuses, only: %i[index new create edit update destroy] do
        collection do
          get :processing
          post :processing, action: :process_match, as: nil
        end
      end
      resources :bonus_checks, only: %i[create]
    end

    resources :nations, only: %i[index new create edit update]

    resources :visits, only: %i[index]
  end

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
