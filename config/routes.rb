Rails.application.routes.draw do
  resources :users
  resources :playlists
  resources :songs 
  resources :playlists_songs 
  resources :categories 
  resources :singers
  get "/playlists/user/:id" , to: 'playlists#show_from_user'
  post 'auth/login' , to: 'authentication#login'
  post "search/:search" => "songs#search" 
  post "searchsinger/:search" => "singers#search"
  post "searchcategories/:search" => "categories#search"
  post "searchusers/:search" => "users#search"
  post "sort" => "playlists_songs#sort"
  # get "/*a" , to: 'application#not_found'
end
