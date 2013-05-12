class PostsController < ApplicationController
  respond_to :html
  respond_to :rss, only: :index
  before_filter :find_post, only: [:show, :edit, :update, :destroy]
  before_filter :init_post, only: [:new, :create]
  before_filter :authorize_action!, except: [:index]

  def index
    @posts = Post.published.page(params[:page]).per(10)
    respond_with @posts
  end

  def new
    respond_with @post
  end

  def create
    @post.attributes = post_params
    @post.author = current_user
    @post.save
    respond_with @post
  end

  def show
    respond_with @post
  end

  def edit
    respond_with @post
  end

  def update
    @post.update_attributes(post_params)
    respond_with @post
  end

  def show
    respond_with @post
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def init_post
    @post = Post.new
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def authorize_action!
    authorize! @post
  end

  def post_params
    params.require(:post).permit(:title, :content, :posted_at)
  end
end

