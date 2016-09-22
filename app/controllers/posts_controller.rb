class PostsController < ApplicationController
  layout 'main_layout'
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :owned_post, only: [:edit, :update, :destroy]

  def index
    @user = User.find_by(name: params[:name])
    @posts = Post.all.order("Created_at DESC").page params[:page]
  end

  def new
    @post = current_user.posts.build
  end

  def create
     @post = current_user.posts.build(post_params)

     if @post.save
      flash[:success] = "Your post has been created."
      redirect_to posts_path
    else
      flash[:alert] = "Your new post couldn't be created!. Please check the form."
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post updated."
      redirect_to posts_path
    else
      flash.now[:alert] = "Update failed. Pleae check the form."
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  def like
    if @post.liked_by current_user
      respond_to do |format|
        format.js
        format.html { redirect_to :back }

      end
    end
  end

  def unlike
    if @post.unliked_by current_user
      respond_to do |format|
        format.js
        format.html { redirect_to :back }
      end
    end
  end



  private

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def correct_user
    unless @post.user.id == current_user.id
      flash[:alert] = "That post doesn't belong to you!"
      redirect_to root_path
    end
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
