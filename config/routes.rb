Rails.application.routes.draw do
  root to: 'pages#index'
  get '/miracles(/*id)', to: 'miracles#index'
end
