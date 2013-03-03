class ArticlesController < Controller

  get :index do
    @articles = Article.published.page(params[:page]).per_page(10)
    render 'articles/index'
  end

  get :show, with: :id do
    @article = Article.find(params[:id])
    render 'articles/show'
  end

  get :new do
    require_admin_user!
    @article = Article.new
    render 'articles/new'
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

end

Downthemall.controller :articles do
  ArticlesController.install_routes!(self)
end

