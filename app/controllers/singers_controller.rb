class SingersController < ApplicationController
  before_action :authorize_request , except: :search

  def index 
      @singers = Singer.all.includes(image_attachment: :blob)
      render json: @singers.map{|singer| {id: singer.id , name: singer.name,  image: rails_blob_url(singer.image, only_path: true)}}, status: :ok 
  end 


  def search 
    @parameter = params[:search]
    
    @singers = Singer.all.includes(image_attachment: :blob)
    @singers = @singers.where("singers.name LIKE ? ", "%#{@parameter}%")
    render json: @singers.map{|singer| {id: singer.id , name: singer.name, image: rails_blob_url(singer.image, only_path: true)}}, status: :ok 
  end

  def create 
    @singer = Singer.new(singer_params)
    
    if @singer.save
      
        @singer.image.attach(params[:file])
      
    end
  end 

  def destroy
    @singer = Singer.find(params[:id])

    @singer.destroy
  end

  private 
    
  
    def singer_params
        params.permit(:name)
    end



end
