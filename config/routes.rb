Rails.application.routes.draw do
  resources :users, defaults: {format: :json}, except: [:index, :new, :edit]

  resources :friends, only: [:show, :create, :update]

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
