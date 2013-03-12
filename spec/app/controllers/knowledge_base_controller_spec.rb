require 'spec_helper'

describe KnowledgeBaseController do
  let(:user) { stub('User') }
  let(:revision) { stub('Revision').as_null_object }

  before do
    AdminMailer.as_null_object
    controller.stub(:current_user).and_return(user)
  end

  describe 'GET /new' do
    let(:action!) { get :new }
    before do
      Revision.stub(:new).and_return(revision)
    end
    it "authorizes action" do
      controller.should_receive(:authorize!).with(revision)
      action!
    end
    it "assigns a new revision" do
      action!
      expect(assigns[:revision]).to eq(revision)
    end
  end

  describe 'GET /edit' do
    let(:action!) { get :edit, id: 'foo' }
    before do
      revision.stub(:latest_revision).and_return('latest')
      Revision.stub(:find).with('foo').and_return(revision)
    end
    it "uses the latest revision available" do
      action!
      expect(assigns[:revision]).to eq('latest')
    end
    it "authorizes action" do
      controller.should_receive(:authorize!).with('latest')
      action!
    end
  end

  describe 'POST /create' do
    let(:action!) { post :create, revision: 'params' }
    before do
      I18n.stub(:locale).and_return(:it)
      Revision.stub(:build).with(:it, user, 'params').and_return(revision)
      revision.stub(:save)
    end
    it "authorizes action" do
      controller.should_receive(:authorize!).with(revision)
      action!
    end
    it "assigns the revision" do
      action!
      expect(assigns[:revision]).to eq(revision)
    end
    context "when revision is valid" do
      before { revision.stub(:save).and_return(true) }
      it "adds a notice and redirects to the revision" do
        action!
        expect(flash[:notice]).not_to be_blank
        expect(redirect_url).to eq(controller.url(:knowledge_base, :show, id: revision))
      end
      it "sends a mail to notify admins" do
        AdminMailer.should_receive(:to_moderate!).with(revision)
        action!
      end
    end
    context "when revision is invalid" do
      before { revision.stub(:save).and_return(false) }
      it "renders the form again" do
        action!
        expect(rendered_view).to eq('knowledge_base/new')
      end
    end
  end

  describe 'POST /update' do
    let(:action!) { post :update, id: 'foo', revision: 'params' }
    let(:new_revision) { stub('Revision') }
    before do
      Revision.stub(:find).with('foo').and_return(revision)
      revision.stub(:build_updated).with(user, 'params').and_return(new_revision)
      new_revision.stub(:save)
    end
    it "authorizes action" do
      controller.should_receive(:authorize!).with(revision)
      action!
    end
    it "assigns the new revision" do
      action!
      expect(assigns[:revision]).to eq(new_revision)
    end
    context "when new revision is valid" do
      before { new_revision.stub(:save).and_return(true) }
      it "adds a notice and redirects to the revision" do
        action!
        expect(flash[:notice]).not_to be_blank
        expect(redirect_url).to eq(controller.url(:knowledge_base, :show, id: new_revision))
      end
      it "sends a mail to notify admins" do
        AdminMailer.should_receive(:to_moderate!).with(new_revision)
        action!
      end
    end
    context "when new revision is invalid" do
      before { new_revision.stub(:save).and_return(false) }
      it "renders the form again" do
        action!
        expect(rendered_view).to eq('knowledge_base/edit')
      end
    end
  end

  describe 'GET /:id/destroy' do
    let(:action!) { get :destroy, id: 'foo' }
    before { Revision.stub(:find).with('foo').and_return(revision) }
    it "authorizes action" do
      controller.should_receive(:authorize!).with(revision)
      action!
    end
    it "destroys the revision" do
      revision.should_receive(:destroy!)
      action!
    end
    it "redirects to index with notice" do
      action!
      expect(flash[:notice]).not_to be_blank
      expect(redirect_url).to eq(controller.url(:knowledge_base, :index))
    end
  end

  describe 'GET /:id/approve' do
    let(:action!) { get :approve, id: 'foo' }
    before { Revision.stub(:find).with('foo').and_return(revision) }
    it "authorizes action" do
      controller.should_receive(:authorize!).with(revision)
      action!
    end
    it "destroys the revision" do
      revision.should_receive(:approve!)
      action!
    end
    it "redirects to index with notice" do
      action!
      expect(flash[:notice]).not_to be_blank
      expect(redirect_url).to eq(controller.url(:knowledge_base, :show, id: revision))
    end
  end

end

