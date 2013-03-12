require 'spec_helper'

describe SessionsController do

  describe 'GET /sign_in' do
    let(:action!) { get :sign_in }
    it_requires 'non-logged users'

    it "renders assigning a new User" do
      User.stub(:new).and_return('user')
      controller.stub(:current_user).and_return(nil)
      action!
      expect(assigns[:user]).to eq('user')
      expect(rendered_view).to eq('sessions/sign_in')
    end
  end

  describe 'POST /sign_in' do
    let(:action!) { post :sign_in, email: 'email', password: 'password' }
    it_requires 'non-logged users'

    context "if authentication passes" do
      it "redirects with notice" do
        controller.stub(:current_user).and_return(nil)
        user = double('User', id: 'foo')
        controller.stub(:authenticate).with('email', 'password').and_return(user)
        action!
        expect(flash[:notice]).not_to be_blank
        expect(redirect_url).to eq(controller.url(:index))
      end
    end

    context "else" do
      it "renders the sign in form again" do
        controller.stub(:current_user).and_return(nil)
        user = double('User', id: 'foo')
        controller.stub(:authenticate!).with('email', 'password').and_return(false)
        action!
        expect(flash.now[:alert]).not_to be_blank
        expect(rendered_view).to eq('sessions/sign_in')
      end
    end
  end

  describe 'GET /sign_out' do
    let(:action!) { get :sign_out }
    it_requires 'logged users'

    it "renders the sign in form again" do
      controller.stub(:current_user).and_return('user')
      session[:user_id] = 'foo'
      action!
      expect(session[:user_id]).to be_blank
      expect(flash[:notice]).not_to be_blank
      expect(redirect_url).to eq(controller.url(:index))
    end
  end

end
