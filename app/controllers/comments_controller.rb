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
    @comments = Comment.where(song_id: params[:song_id] , parent_id: nil).includes(:song , user: {avatar_attachment: :blob}).order("created_at DESC")
    render json: @comments.map{|comment| {name: comment.user.name, reply: comment.reply , content: comment.content , id: comment.id , image: comment.user.avatar.attached? ? rails_blob_url( comment.user.avatar, only_path: true) : ""}}
  end

  def destroy 
    @comment = Comment.find(params[:id])
    if !@comment.parent_id.nil?
      @parent = Comment.find_by(id: @comment.parent_id)
      count = @parent.reply - 1
      @parent.update_attribute(:reply , count)
    end
    @replies = Comment.where(parent_id: params[:id]).includes(:song , user: {avatar_attachment: :blob}).order("created_at DESC")
    @replies.destroy_all
    @comment.destroy
  end 

  def reply
    @reply = Comment.new(reply_params)
    @comment = Comment.find_by(id: params[:parent_id])
    count = @comment.reply + 1
    if @reply.save
      @comment.update_attribute(:reply , count)
    end
  end

  def getreply
    @comments = Comment.where(parent_id: params[:id]).includes(:song , user: {avatar_attachment: :blob}).order("created_at DESC")
    render json: @comments.map{|comment| {name: comment.user.name, reply: comment.reply , content: comment.content , id: comment.id , image: comment.user.avatar.attached? ? rails_blob_url( comment.user.avatar, only_path: true) : ""}}
  end

  private 
  def comment_params
    params.permit(:song_id , :user_id , :content)
  end

  def reply_params
    params.permit(:song_id , :user_id , :content , :parent_id)

  end


end
