Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
  # Defines the root path route ("/")
  root "sessions#welcome", defaults: {tab: "homepage"}
  
  get '/welcome', to: "home#welcome"
  get "/login", to: "sessions#login"
  get "/sign_up", to: "admin/users#new"
  post "/verify", to: "sessions#verify"
  delete "/logout", to: "sessions#destroy"

  get "/forgot", to: "sessions#forgot"
  post "/reset_password", to: "sessions#reset"

  namespace :api do
    namespace :v1 do
      resources :train_routes, only: %i[index] do
        collection do
          get :booking_price
          get :password_reset_token
          get :pnr_details
          get :available_seats
        end
      end
    end
  end

  
  # draw(:admin) # define routes in seprate file
  namespace :admin do
    resources :users, except: %i[destroy], defaults: {tab: "users"} do
      post :assign_role,    on: :member
      post :account_status, on: :member

    end

    resources :trains, except: %i[show], defaults: {tab: "trains"} do
      resource :route_detail, only: %i[show]
    end

    resources :schedules, except: %i[show] , defaults: {tab: "schedule"} do
    end

    # resources :coaches, only: %i[index new create], defaults: {tab: "coaches"}
    resources :coaches, except: %i[show], defaults: {tab: "coaches"}

    resources :seats, except: %i[show], defaults: {tab: "seats"}

    resources :tiers, defaults: {tab: "tiers"}

    resource :dashboard, only: %i[show], defaults: {tab: "dashboard"}
  end

  resources :bookings, except: %i[edit destroy], defaults: {tab: "booking"}  do
    get :check_availability, on: :collection

    resource :ticket, only: %i[show destroy]
  end

  resources :payments, only: %i[new create update]
  
  get "/search", to: "search#new"
  get "/search-query", to: "search#search"
  
 resource :profile, only: %i[show edit], defaults: {tab: "profile"}
  
 resources :tests if Rails.env.development?
 
end
