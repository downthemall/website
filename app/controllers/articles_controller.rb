class ArticlesController < Controller

  get :index, provides: [:html, :rss] do
    @articles = Article.published.page(params[:page]).per_page(10)
    render 'articles/index'
  end

  get :new, map: '/articles/new' do
    require_admin_user!
    @article = Article.new
    render 'articles/new'
  end

  get :show, map: '/articles/:id' do
    @article = Article.find(params[:id])
    render 'articles/show'
  end

  post :create do
    require_admin_user!
    @article = Article.new(params[:article])
    @article.author = current_user
    if @article.save
      redirect url(:articles, :show, id: @article)
    else
      render 'articles/new'
    end
  end

  get :edit, map: '/articles/:id/edit' do
    require_admin_user!
    @article = Article.find(params[:id])
    render 'articles/edit'
  end

  post :update, map: '/articles/:id' do
    require_admin_user!
    @article = Article.find(params[:id])
    @article.attributes = params[:article]
    if @article.save
      redirect url(:articles, :show, id: @article)
    else
      render 'articles/edit'
    end
  end

  get :destroy, map: '/articles/:id/delete' do
    require_admin_user!
    article = Article.find(params[:id])
    article.destroy
    redirect url(:articles, :index)
  end

end

Downthemall.controller :articles do
  ArticlesController.install_routes!(self)
end

