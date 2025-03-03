Rails.application.routes.draw do

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  
  post "/graphql", to: "graphql#execute"
  post '/register', to: 'users#register'
  post '/login', to: 'users#login'

  resources :tasks, except: [:new, :edit]
end
