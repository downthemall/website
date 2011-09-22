class ArticlesController < ApplicationController
  inherit_resources
  actions :index, :create, :new
  respond_to :html

  def index
    @sticky_articles = Article.sticky
    index!
  end

end
