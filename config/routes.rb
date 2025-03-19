Rails.application.routes.draw do
  # API Routes

  namespace :api do
    namespace :v1 do
      post "login", to: "sessions#create"
      post "signup", to: "users#create"
      get "cars", to: "cars#index"
      resources :users, only: [ :create ] do
          resources :cars, only: [ :create ] do
            resources :maintenance_records, only: [ :create, :index ]
          end
        end
    end
  end


  get "users/new"
  get "users/create"
  resource :session
  resources :pages
  resources :passwords, param: :token
  resources :users do
    resources :cars do
      resources :maintenance_records, only: [ :new, :create, :index, :show, :edit, :update, :destroy ]
    end
  end



  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "pages#home"
  get "dashboard", to: "pages#dashboard"
  get "/signup", to: "users#new"
  post "/users", to: "users#create"
end
