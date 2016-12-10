class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    parent_comment = Comment.find_by(id: comment_params[:parent_comment_id])
    @comment.post_id = parent_comment.nil? ?
      params[:post_id] : parent_comment.post_id
    if @comment.save
      redirect_to post_url(@comment.post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end



  def comment_params
    params.require(:comment).permit(:content, :parent_comment_id)
  end
end
