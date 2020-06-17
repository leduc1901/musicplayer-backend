class SongsController < ApplicationController
    before_action :authorize_request
    def index 
        @songs = Song.all 
        render json: @songs.map{|song| {id: song.id , name: song.name , category: song.category.name , image: song.singer.image , singer: song.singer.name , url: song.url}}, status: :ok
    end
end
