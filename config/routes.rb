Rails.application.routes.draw do
  resources :save_tweets, except: [:new, :edit]

  delete 'users' => 'users#destroy'
  get 'users' => 'users#show'
  post 'users/update' => 'users#update'
  resources :users, defaults: {format: :json}, only: [:create]

  resources :friends, only: [:show, :create, :update]
  resources :friends, param: :twitterId, only: :destroy

  post '/login', to: 'users#login'
  get '/logout', to: 'users#logout'

 # get '/user/:twitterUsername', to: "users#show"

 match '/callbacks' => 'callbacks#request_token', via: [:get,:post]

 match '/callbacks/twitter' => 'callbacks#twitter_callback', via: [:get, :post]

resources :sessions, only: [:create, :destroy]
 match '/signout' => 'sessions#destroy', via: [:get, :post]

resources :categories

match '/tweets' => 'tweets#index', via: [:get]

end
