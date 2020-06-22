class SongsController < ApplicationController
    before_action :authorize_request
    def index 
        @songs = Song.all.includes(:category, {song_url_attachment: :blob} , singer: {image_attachment: :blob} )
        render json: @songs.map{|song| {id: song.id , name: song.name , category: song.category.name , image: rails_blob_url(song.singer.image, only_path: true), singer: song.singer.name , url: rails_blob_url(song.song_url, only_path: true)}}, status: :ok
    end
end
