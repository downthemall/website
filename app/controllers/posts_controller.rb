class PostsController < Controller

  get :index, map: '/news', provides: [:html, :rss] do
    @posts = Post.published.page(params[:page]).per_page(10)
    render 'posts/index'
  end

  get :new, map: '/news/new' do
    @post = Post.new
    authorize! @post
    render 'posts/new'
  end

  get :show, map: '/news/:id' do
    @post = Post.find(params[:id])
    render 'posts/show'
  end

  post :create do
    @post = Post.new(params[:post])
    authorize! @post
    @post.author = current_user
    if @post.save
      redirect url(:posts, :show, id: @post)
    else
      render 'posts/new'
    end
  end

  get :edit, map: '/news/:id/edit' do
    @post = Post.find(params[:id])
    authorize! @post
    render 'posts/edit'
  end

  post :update, map: '/news/:id' do
    @post = Post.find(params[:id])
    authorize! @post
    @post.attributes = params[:post]
    if @post.save
      redirect url(:posts, :show, id: @post)
    else
      render 'posts/edit'
    end
  end

  get :destroy, map: '/news/:id/delete' do
    post = Post.find(params[:id])
    authorize! post
    post.destroy
    redirect url(:posts, :index)
  end

end

Downthemall.controller :posts do
  PostsController.install_routes!(self)
end

