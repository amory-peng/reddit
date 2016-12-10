class PostsController < ApplicationController
  before_action :require_owner, only: [:update, :edit, :destroy]

  def new
    @post = Post.new
    @subs = Sub.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def upvote
    user_id = current_user.id
    value = 1
    vote = Vote.create(user_id: user_id, value: value)
    @post = Post.find(Post.friendly.find(params[:id]))
    @post.votes << vote
    redirect_to post_url(@post)
  end

  def downvote
    user_id = current_user.id
    value = -1
    vote = Vote.create(user_id: user_id, value: value)
    @post = Post.find(Post.friendly.find(params[:id]))
    @post.votes << vote
    redirect_to post_url(@post)
  end

  def update
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find(Post.friendly.find(params[:id]))
    # @all_comments = Comment.includes(:user)
    @all_comments = @post.comments_by_parent_id
  end

  def destroy
    @post = Post.find(Post.friendly.find(params[:id]))
    @post.destroy
    redirect_to sub_url(@post.sub)
  end

  def edit
    @subs = Sub.all
    @post = Post.find(Post.friendly.find(params[:id]))
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

  def require_owner
    post = Post.find_by(id: Post.friendly.find(params[:id]))
    redirect_to post_url(post) unless post.owner.id == current_user.id
  end
end
