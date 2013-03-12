require 'spec_helper'

describe PostsController do

  let(:user) { stub('User') }

  describe 'GET /new' do
    let(:action!) { get :new }
    before {
      Post.should_receive(:new).and_return('post')
    }
    it "authorizes action" do
      controller.should_receive(:authorize!).with('post')
      action!
    end
    it "assigns a new post" do
      action!
      expect(assigns[:post]).to eq('post')
    end
  end

  describe 'POST /create' do
    let(:action!) { make_request :post, :create, post: 'foo' }
    let(:post) { stub('Post').as_null_object }
    before {
      controller.stub(:current_user).and_return(user)
      Post.stub(:new).with('foo').and_return(post)
    }
    it "authorizes action" do
      controller.should_receive(:authorize!).with(post)
      action!
    end
    it "assigns an post with the specified params" do
      action!
      expect(assigns[:post]).to eq(post)
    end
    it "assigns current user as author" do
      post.should_receive(:author=).with(user)
      action!
    end
    context "when model gets saved" do
      before { post.stub(:save).and_return(true) }
      it "redirects to the post" do
        action!
        expect(redirect_url).to eq(controller.url(:posts, :show, id: post))
      end
    end
    context "when model does not get saved" do
      before { post.stub(:save).and_return(false) }
      it "renders" do
        action!
        expect(rendered_view).to eq('posts/new')
      end
    end
  end

  describe 'POST /update' do
    let(:action!) { make_request :post, :update, id: 'foo', post: 'data' }
    let(:post) { stub('Post').as_null_object }
    before {
      Post.stub(:find).with('foo').and_return(post)
    }
    it "authorizes action" do
      controller.should_receive(:authorize!).with(post)
      action!
    end
    it "assigns an post with the specified params" do
      action!
      expect(assigns[:post]).to eq(post)
    end
    it "updates attributes" do
      post.should_receive(:attributes=).with('data')
      action!
    end
    context "when model gets saved" do
      before { post.stub(:save).and_return(true) }
      it "redirects to the post" do
        action!
        expect(redirect_url).to eq(controller.url(:posts, :show, id: post))
      end
    end
    context "when model does not get saved" do
      before { post.stub(:save).and_return(false) }
      it "renders" do
        action!
        expect(rendered_view).to eq('posts/edit')
      end
    end
  end

  describe 'GET /edit' do
    let(:action!) { get :edit, id: 'foo' }
    let(:post) { stub('Post').as_null_object }
    before {
      Post.stub(:find).with('foo').and_return(post)
    }
    it "authorizes action" do
      controller.should_receive(:authorize!).with(post)
      action!
    end
    it "assigns an post with the specified params" do
      action!
      expect(assigns[:post]).to eq(post)
    end
  end

  describe 'GET /delete' do
    let(:action!) { get :destroy, id: 'foo' }
    let(:post) { stub('Post').as_null_object }
    before {
      Post.stub(:find).with('foo').and_return(post)
    }
    it "authorizes action" do
      controller.should_receive(:authorize!).with(post)
      action!
    end
    it "destroys the post" do
      post.should_receive(:destroy)
      action!
    end
    it "redirects to index" do
      action!
      expect(redirect_url).to eq(controller.url(:posts, :index))
    end
  end

end

