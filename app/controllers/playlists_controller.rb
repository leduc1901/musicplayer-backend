class PlaylistsController < ApplicationController
    before_action :authorize_request
    def index 
        @playlists = Playlist.where(privacy: "public").includes(:user)
        render json: @playlists.map { |playlist| {id: playlist.id , name: playlist.name , user: playlist.user.name, user_id: playlist.user_id} }
    end

    def show_from_user
        @playlists = Playlist.where(user_id: params[:id])
        render json: @playlists.map { |playlist| {id: playlist.id, privacy: playlist.privacy , name: playlist.name , user: playlist.user.name , user_id: playlist.user_id} }
    end

    def show
        @playlist = Playlist.find( params[:id])
        render json:  {user_id: @playlist.user_id ,songs: @playlist.playlists_songs.includes(song: [:category, {song_url_attachment: :blob} , singer: {image_attachment: :blob} ]).order("playlists_songs.song_index ASC" ).map do |playlists_song|
            {
                id: playlists_song.id ,
                name: playlists_song.song.name,
                singer: playlists_song.song.singer.name,
                song_id: playlists_song.song.id,
                image: rails_blob_url(playlists_song.song.singer.image, only_path: true) ,
                url: rails_blob_url(playlists_song.song.song_url, only_path: true),
                category: playlists_song.song.category.name,
                index: playlists_song.song_index
            }
        end
    }    
    end

    def send_mail 
        @playlist = Playlist.find( params[:id])
        @user = User.find(@playlist.user_id)
        @listener = User.find(params[:name])
        UserMailer.send_email(@user , @listener).deliver_now
        render json: {status: "success"}
    end

   
    def update 
        @playlist = Playlist.find(params[:id])
        if params[:song_id] != nil
            @playlist.playlists_songs_attributes = {id: params[:song_id] , _destroy: '1'}
            if @playlist.save
                render json: @playlist
            end
        end
        if params[:privacy] != nil
            if @playlist.update_attribute(:privacy , params[:privacy])
                render json: @playlist
            end
        end
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
        params.require(:playlist).permit(:name, :privacy , :user_id , :playlists_songs_attributes => [:song_id , :song_index])
    end

end
