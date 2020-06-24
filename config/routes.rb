Rails.application.routes.draw do
  resources :users
  resources :playlists
  resources :songs 
  resources :playlists_songs 
  resources :categories , param: :slug
  get "/playlists/user/:id" , to: 'playlists#show_from_user'
  post 'auth/login' , to: 'authentication#login'
  post "search/:search" => "songs#search" 
  # get "/*a" , to: 'application#not_found'
end
