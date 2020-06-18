class PlaylistsController < ApplicationController
    before_action :authorize_request
    def index 
        @playlists = Playlist.where(privacy: "public")
        render json: @playlists.map { |playlist| {id: playlist.id , name: playlist.name , user: playlist.user.name , songs: playlist.songs} }
    end

    def show_from_user
        @playlists = Playlist.where(user_id: params[:id])
        render json: @playlists.map { |playlist| {id: playlist.id , name: playlist.name , user: playlist.user.name} }
    end

    def show 
        @playlist = Playlist.where(id: params[:id])
        render json: @playlist.map { |p| {songs: p.songs.map{|song| {id: song.id , name: song.name , category: song.category.name , image: song.singer.image , singer: song.singer.name , url: song.url} }}}
    end

end
