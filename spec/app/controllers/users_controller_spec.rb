require 'spec_helper'

describe UsersController do

  describe 'GET /sign_up' do
    let(:action!) { get :sign_up }
    it_requires 'non-logged users'

    it "renders" do
      controller.stub(:current_user).and_return(nil)
      action!
      rendered_view.should == 'users/sign_up'
    end
  end

  describe 'POST /sign_up' do
    let(:action!) { post :sign_up, user: { email: 'email', password: 'password' } }
    it_requires 'non-logged users'

    it "if user is valid, it saves session, and redirects with notice" do
      controller.stub(:current_user).and_return(nil)
      user = double('User', save: true, id: 'foo')
      Authentication.stub(:create_user).with('email', 'password').and_return(user)
      action!
      flash[:notice].should_not be_blank
      session[:user_id].should == 'foo'
      redirect_url.should == controller.url(:index)
    end

    it "if user is valid, it saves session, and redirects with notice" do
      controller.stub(:current_user).and_return(nil)
      user = double('User', save: false)
      Authentication.stub(:create_user).and_return(user)
      action!
      rendered_view.should == 'users/sign_up'
    end
  end

end
