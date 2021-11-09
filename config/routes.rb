Rails.application.routes.draw do
  root :to => redirect('/login')
  resources :users
  get '/main_page', to: 'login#index'
  get '/login', to: 'login#login_new'
  post '/login',to: 'login#create'
  get '/register', to: 'login#register_new'
  post '/register',to: 'login#register'
  get '/logout',to: 'login#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
