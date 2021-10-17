Rails.application.routes.draw do
  root 'login#index'
  resources :users
  get '/login', to: 'login#login_new'
  post '/login',to: 'login#create'
  get '/register', to: 'login#register_new'
  post '/register',to: 'login#register'
  get '/logout',to: 'login#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
