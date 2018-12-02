#Rails.application.routes.draw do
Miracles::Application.routes.draw do
  root to: 'pages#index'
  get '/miracles(/*id)', to: 'miracles#index'
  
  namespace :users do
    resources :users
  end
end
