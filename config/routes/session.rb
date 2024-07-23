root "sessions#welcome", defaults: {tab: "homepage"}
  
get '/welcome', to: "home#welcome"
get "/login", to: "sessions#login"
get "/sign_up", to: "admin/users#new"
post "/verify", to: "sessions#verify"
delete "/logout", to: "sessions#destroy"

get "/forgot", to: "sessions#forgot"
post "/reset_password", to: "sessions#reset"