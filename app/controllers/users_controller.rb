class UsersController < ApplicationController
    before_action :authorize_request, except: [:create, :search]
    
    def index 
        @users = User.all.includes(avatar_attachment: :blob)
        render json: @users.map{|user| {id: user.id ,name: user.name , email: user.email , avatar: user.avatar.attached? ? rails_blob_url( user.avatar, only_path: true) : ""}  }, status: :ok
    end

    def show 
        @user = User.find(params[:id])
        if @user.avatar.attached?
            render json: {id: @user.id ,name: @user.name , email: @user.email , avatar: rails_blob_url(@user.avatar, only_path: true)}, status: :ok 
        else  
            render json: {id: @user.id ,name: @user.name , email: @user.email , avatar: ""}, status: :ok 
        end
    end

    def create 
        @user = User.new(user_params)
        if @user.save 
            render json: @user , status: :created 
        else
            render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity

        end
    end


    def update 
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
            @user.avatar.attach(params[:file])
            render json: @user
        else 
            render json: @user
        end
    end

    def destroy
        @user = User.find(params[:id])
    
        @user.destroy
    end

   
    def search 
        @parameter = params[:search]
        @users = User.all.includes(avatar_attachment: :blob )
        @users = @users.where("users.name LIKE ?", "%#{@parameter}%")
        render json: @users.map{|user| {id: user.id , name: user.name , email: user.email , avatar: user.avatar.attached? ? rails_blob_url( user.avatar, only_path: true) : ""}  }, status: :ok

    end

    private 
    
  
    def user_params
        params.permit(:name, :email , :password , :password_confirmation)
    end



end
