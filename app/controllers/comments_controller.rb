class CommentsController < ApplicationController
  before_action :authorize_request 

  def create 
    @comment = Comment.new(comment_params)
        if @comment.save
            render json: @comment
        end
  end 

  def get_comment
    @comments = Comment.where(song_id: params[:song_id]).includes(:song , user: {avatar_attachment: :blob}).order("created_at DESC")
    render json: @comments.map{|comment| {name: comment.user.name , content: comment.content , id: comment.id , image: comment.user.avatar.attached? ? rails_blob_url( comment.user.avatar, only_path: true) : ""}}
  end

  def destroy 
    @comment = Comment.find(params[:id])
    @comment.destroy
  end 

  private 
  def comment_params
    params.permit(:song_id , :user_id , :content)
end


end
