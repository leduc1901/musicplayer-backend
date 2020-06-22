class PlaylistsController < ApplicationController
    before_action :authorize_request
    def index 
        @playlists = Playlist.where(privacy: "public")
        render json: @playlists.map { |playlist| {id: playlist.id , name: playlist.name , user: playlist.user.name, user_id: playlist.user_id} }
    end

    def show_from_user
        @playlists = Playlist.where(user_id: params[:id])
        render json: @playlists.map { |playlist| {id: playlist.id , name: playlist.name , user: playlist.user.name , user_id: playlist.user_id} }
    end

    def show 
        @playlist = Playlist.find( params[:id])    
        render json:  {songs: @playlist.playlists_songs.map do |playlists_song|
            {
                id: playlists_song.id ,
                name: playlists_song.song.name,
                singer: playlists_song.song.singer.name,
                image: playlists_song.song.singer.image ,
                url: playlists_song.song.url,
                category: playlists_song.song.category.name
            }
        end
    }    
    end

    def destroy 
        @playlist = Playlist.find(params[:id])
        @playlist.destroy
    end

    def create 
        @playlist = Playlist.new(playlist_params)
        if @playlist.save 
            render json: @playlist , status: :created 
        else
            render json: {errors: @playlist.errors.full_messages}, status: :unprocessable_entity
        end
    end

    private 
    def playlist_params
        params.require(:playlist).permit(:name, :privacy , :user_id)
    end

end
