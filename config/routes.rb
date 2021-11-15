Rails.application.routes.draw do
  root :to => redirect('/login')
  resources :users do
    resources :schedule_actual_times
  end
  get '/main_page', to: 'dashboard#index'
  get '/login', to: 'login#login_new'
  post '/login',to: 'login#create'
  get '/register', to: 'login#register_new'
  post '/register',to: 'login#register'
  get '/register_user', to: 'dashboard#register_user'
  post '/register_user',to: 'dashboard#register'
  get '/logout',to: 'dashboard#destroy'
  get '/timestamp/:id',to: 'dashboard#check_timestamp',as: 'timestamp'
  get '/manage_user',to: 'manage_user#index'
  post '/manage_user',to: 'manage_user#set_plan'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
