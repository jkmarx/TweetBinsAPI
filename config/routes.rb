Rails.application.routes.draw do
  resources :users, except: [:new, :edit] do
    resources :categories, only: [:index, :show]
  end

 # get '/user/:twitterUsername', to: "users#show"

 match '/callbacks' => 'callbacks#request_token', via: [:get,:post]

 match '/callbacks/twitter' => 'callbacks#twitter_callback', via: [:get, :post]

resources :sessions, only: [:create, :destroy]
 match '/signout' => 'sessions#destroy', via: [:get, :post]

  resources :categories, only: [:create, :destroy]

end
