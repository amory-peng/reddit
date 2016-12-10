class SubsController < ApplicationController
  before_action :require_owner, only: [:update, :edit, :destroy]
  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    if @sub.save
      redirect_to subs_url
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to subs_url
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def index
    @subs = Sub.all
  end

  def destroy
    sub = Sub.find(params[:id])
    sub.destroy
    redirect_to subs_url
  end

  def show
    @sub = Sub.find(params[:id])
    # fail
    @posts = @sub.posts.sort_by do |post|
      post.votes.sum(:value)
    end.reverse
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def require_owner
    sub = Sub.find_by(id: params[:id])
    redirect_to subs_url unless sub.owner == current_user
  end
end
