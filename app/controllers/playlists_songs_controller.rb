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

    def sort 
        params[:array].each do |item| 
            @song = PlaylistsSong.find(item[:id])
            @song.update_attribute(:song_index , item[:index])
        end
        render json: params
    end

    private 
    
    def song_params 
        params.require(:playlists_song).permit(:playlist_id , :song_id , :song_index)
    end
end
