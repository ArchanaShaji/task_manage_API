Rails.application.routes.draw do
  post '/register', to: 'users#register'
  post '/login', to: 'users#login'

  resources :tasks, except: [:new, :edit]
end
