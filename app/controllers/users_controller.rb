class UsersController < ApplicationController
    before_action :authorize_request, except: :create

    def index 
        @users = User.all.to_json(except: :avatar)
        render json: @users, status: :ok
    end

    def show 
        @user = User.find(params[:id])
        if @user.avatar.attached?
            render json: {name: @user.name , email: @user.email , avatar: rails_blob_url(@user.avatar, only_path: true)}, status: :ok 
        else  
            render json: {name: @user.name , email: @user.email , avatar: ""}, status: :ok 
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
        @user = User.find_by(params[:id])
        if params[:file]
            @user.avatar.attach(params[:file])
        end
    end
   
    private 
    
  
    def user_params
        params.require(:user).permit(:name, :email , :password , :password_confirmation)
    end



end
