require 'spec_helper'

describe ArticlesController do

  let(:user) { stub('User', admin?: true) }

  describe 'GET /new' do
    let(:action!) { get :new }
    it_requires 'admin users'

    context "when admin" do
      before { controller.stub(:current_user).and_return(user) }

      it "assigns a new article" do
        Article.should_receive(:new).and_return('article')
        action!
        assigns[:article].should == 'article'
      end

      it "renders" do
        controller.stub(:current_user).and_return(user)
        action!
        rendered_view.should == 'articles/new'
      end

    end
  end

  describe 'POST /create' do
    let(:action!) { post :create, article: 'foo' }
    let(:article) { stub('Article').as_null_object }

    it_requires 'admin users'

    context "when admin" do
      before {
        controller.stub(:current_user).and_return(user)
        Article.stub(:new).with('foo').and_return(article)
      }

      it "assigns an article with the specified params" do
        action!
        assigns[:article].should == article
      end

      it "assigns current user as author" do
        article.should_receive(:author=).with(user)
        action!
      end

      context "when model gets saved" do
        before { article.stub(:save).and_return(true) }
        it "redirects to the article" do
          action!
          redirect_url.should == controller.url(:articles, :show, id: article)
        end
      end

      context "when model does not get saved" do
        before { article.stub(:save).and_return(false) }
        it "renders" do
          action!
          rendered_view.should == 'articles/new'
        end
      end

    end
  end

end

