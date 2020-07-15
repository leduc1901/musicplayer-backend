class CommentsController < ApplicationController
  before_action :authorize_request 
  wrap_parameters false

  def create 
    @comment = Comment.new(comment_params)
        if @comment.save
            render json: @comment
        end
  end 

  def get_comment
    @comments = Comment.base_comment.comment_by_id(params[:id]).includes(:song , user: {avatar_attachment: :blob}).order("created_at DESC")
    render json: CommentBlueprint.render(@comments) 
  end

  def destroy 
    @comment = Comment.find(params[:id])
    @replies = Comment.get_reply(params[:id]).includes(:song , user: {avatar_attachment: :blob}).order("created_at DESC")
    @replies.destroy_all
    @comment.destroy
  end 

  def reply
    @reply = Comment.new(reply_params)
    @comment = Comment.find_by(id: params[:id])
    count = @comment.reply + 1
    if @reply.save
      @comment.update_attribute(:reply , count)
    end
  end

  def getreply
    @comments = Comment.find(params[:id])
    
    render json: CommentBlueprint.render(@comments.replies) 

  end

  private 
  def comment_params
    params.permit(:song_id , :user_id , :content)
  end

  def reply_params
    params.permit(:song_id , :user_id , :content , :parent_id)
  end

end
