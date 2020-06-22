class PlaylistsSongsController < ApplicationController
   

    def create 
            @newSong = PlaylistsSong.new(song_params)
            if @newSong.save 
                render json: @newSong , status: :created 
            else
                render json: {errors: @newSong.errors.full_messages}, status: :unprocessable_entity   
            end
    end

    def destroy
        @song = PlaylistsSong.find(params[:id])
        @song.destroy
    end

    private 
    
    def song_params 
        params.require(:playlists_song).permit(:playlist_id , :song_id)
    end
end
