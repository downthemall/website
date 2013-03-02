require 'spec_helper'

describe SessionsController do

  describe 'GET /sign_in' do
    let(:action!) { get :sign_in }
    it_requires 'non-logged users'

    it "renders assigning a new User" do
      User.stub(:new).and_return('user')
      controller.stub(:current_user).and_return(nil)
      action!
      assigns[:user].should == 'user'
      rendered_view.should == 'sessions/sign_in'
    end
  end

  describe 'POST /sign_in' do
    let(:action!) { post :sign_in, email: 'email', password: 'password' }
    it_requires 'non-logged users'

    it "saves to session and redirects with notice" do
      controller.stub(:current_user).and_return(nil)
      user = double('User', id: 'foo')
      Authentication.stub(:authenticate!).with('email', 'password').and_return(user)
      action!
      session[:user_id].should == 'foo'
      flash[:notice].should_not be_blank
      redirect_url.should == controller.url(:index)
    end

    it "renders the sign in form again" do
      controller.stub(:current_user).and_return(nil)
      user = double('User', id: 'foo')
      Authentication.stub(:authenticate!).with('email', 'password')
        .and_raise(Authentication::Fail)
      action!
      flash.now[:alert].should_not be_blank
      rendered_view.should == 'sessions/sign_in'
    end
  end

  describe 'GET /sign_out' do
    let(:action!) { get :sign_out }
    it_requires 'logged users'

    it "renders the sign in form again" do
      controller.stub(:current_user).and_return('user')
      session[:user_id] = 'foo'
      action!
      session[:user_id].should be_blank
      flash[:notice].should_not be_blank
      redirect_url.should == controller.url(:index)
    end
  end

end
