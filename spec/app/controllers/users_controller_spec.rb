require 'spec_helper'

describe UsersController do

  describe 'GET /sign_up' do
    let(:action!) { get :sign_up }
    it_requires 'non-logged users'

    it "renders" do
      action!
      expect(rendered_view).to eq('users/sign_up')
    end
  end

  describe 'POST /sign_up' do
    let(:action!) { post :sign_up, user: { email: 'email', password: 'password' } }
    it_requires 'non-logged users'

    it "if user is valid, it saves session, and redirects with notice" do
      user = double('User', save: true, id: 'foo')
      User.stub(:new).with(email: 'email', password: 'password').and_return(user)
      action!
      expect(flash[:notice]).not_to be_blank
      expect(session[:user_id]).to eq('foo')
      expect(redirect_url).to eq(controller.url(:index))
    end

    it "if user is valid, it saves session, and redirects with notice" do
      controller.stub(:current_user).and_return(nil)
      user = double('User', save: false)
      User.stub(:new).with(email: 'email', password: 'password').and_return(user)
      action!
      expect(rendered_view).to eq('users/sign_up')
    end
  end

end
