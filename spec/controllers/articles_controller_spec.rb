require 'spec_helper'

describe ArticlesController do

  context ".show" do
    it "should redirect to the english translation of the article itself" do
      @translation = mock_model(ArticleTranslation)
      @article = mock_model(Article, :translation_for => @translation)
      Article.expects(:find).returns @article
      get :show, :id => '42'
      response.should redirect_to(
        :controller => :article_translations,
        :action => :show,
        :article_id => @article,
        :id => @translation
      )
    end
  end

end
