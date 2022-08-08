Rails.application.routes.draw do
  get 'deposit' => 'deposit#index'
  post 'deposit/create' => 'deposit#create'
  get 'request-manager-visit' => 'request_manager#index'
  post 'request-manager/create' => 'request_manager#create'
  get 'transfer' => 'transfer#index'
  post 'transfer/create' => 'transfer#create'
  get 'withdraw' => 'withdraw#index'
  post 'withdraw/create' => 'withdraw#create'
  get 'statement' => 'statement#index'
  get 'sessions/new'
  root 'home#index'
  get '/balance', to: 'balance#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :accounts
  post 'sessions/create' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
end
