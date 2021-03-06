# require 'sidekiq/web'
# require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  resources :users
  resources :playlists
  resources :songs 
  resources :playlists_songs 
  resources :categories 
  resources :singers
  resources :comments do 
    member do 
      get "getreply"
      get "get_comment"
      post "reply"
    end
  end
  get "/playlists/user/:id" , to: 'playlists#show_from_user'
  post 'auth/login' , to: 'authentication#login'
  post "search/:search" => "songs#search" 
  post "searchsinger/:search" => "singers#search"
  post "searchcategories/:search" => "categories#search"
  post "searchusers/:search" => "users#search"
  post "sort" => "playlists_songs#sort"
  post "send_mail" => "playlists#send_mail"
  post "download" => "users#download"
  post "charges" => "charges#create"

end
