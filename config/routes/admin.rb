namespace :admin do
  resources :users, defaults: {tab: "users"} do
    collection do
      get :dashboard
    end
  end

  resources :trains, defaults: {tab: "trains"}
  resources :train_routes, defaults: {tab: "train_route"}
  resources :coaches, defaults: {tab: "coaches"}
  resources :seats, only: %i[index]
end