class SongsController < ApplicationController
    before_action :authorize_request , except: :search
    def index 
        @songs = Song.all.includes(:category, {song_url_attachment: :blob} , singer: {image_attachment: :blob} )
        render json: @songs.map{|song| {id: song.id , name: song.name , category: song.category.name , image: rails_blob_url(song.singer.image, only_path: true), singer: song.singer.name , url: rails_blob_url(song.song_url, only_path: true)}}, status: :ok
    end

    def search 
        @parameter = params[:search]
        
        @songs = Song.all.includes(:category, {song_url_attachment: :blob} , singer: {image_attachment: :blob} )
        @songs = @songs.left_outer_joins(:category , :singer).where("songs.name LIKE ? OR categories.name LIKE ? OR singers.name LIKE ?", "%#{@parameter}%" , "%#{@parameter}%" , "%#{@parameter}%")
        render json: @songs.map{|song| {id: song.id , name: song.name , category: song.category.name , image: rails_blob_url(song.singer.image, only_path: true), singer: song.singer.name , url: rails_blob_url(song.song_url, only_path: true)}}, status: :ok

    end

    def create 
        @song = Song.new(song_params)
        
        if @song.save
        
            @song.song_url.attach(params[:file])
          
        end
    end 

    def destroy 

    end 

    private 

    def song_params
        params.permit(:name , :category_id , :singer_id)
    end


end
