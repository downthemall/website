class ArticlesController < ApplicationController
  inherit_resources
  actions :all
  respond_to :html
  layout :layout_by_action

  def create
    create! { edit_article_path(@article) }
  end

  def update
    update! { edit_article_path(@article) }
  end

  def show
    @article = Article.find(params[:id])
    redirect_to [@article, @article.translation_for(:en)]
  end

  private

  def layout_by_action
    if %(create new edit update destroy).include? action_name
      "twoside_editing"
    else
      "application"
    end
  end

end
