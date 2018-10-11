Rails.application.routes.draw do

  # ---------------
  # Root
  # ---------------
  root 'welcome#index'
  get 'welcome/index'
  
  # ---------------
  # Articles
  # ---------------
  resources :articles do
    put '/revive',    to: 'articles#revive'
    resources :comments
  end
  
  # ---------------
  # Users
  # ---------------
  get  '/signup',     to: 'users#new'
  get  '/profile',    to: 'users#profile'
  resources :users do
    put  '/revive',   to: 'users#revive'
  end

  # ---------------
  # Sessions
  # ---------------
  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'

  # ---------------
  # Tags
  # ---------------
  get  '/tags',       to: 'tags#index'
  post '/tags',       to: 'tags#create'

  # ---------------
  # Search
  # ---------------
  get '/search',      to: 'search#index'

end
