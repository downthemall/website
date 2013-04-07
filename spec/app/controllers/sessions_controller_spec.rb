require 'spec_helper'

describe SessionsController do

  describe 'POST /sign_in' do
    let(:action!) { post :sign_in, assertion: 'foobar' }
    it_requires 'non-logged users'

    before do
      SignIn.stub(:find_or_create_user)
      request.stub(:host_with_port).and_return('host')
    end

    context "if authentication passes" do
      it "authenticates and adds notice" do
        controller.stub(:current_user).and_return(nil)
        user = double('User', id: 'foo')
        SignIn.stub(:find_or_create_user).with('foobar', 'host').and_return(user)
        controller.should_receive(:authenticate!).with(user)
        action!
        expect(flash[:notice]).not_to be_blank
      end
    end

    context "else" do
      it "adds an alert" do
        controller.stub(:current_user).and_return(nil)
        user = double('User', id: 'foo')
        action!
        expect(flash[:alert]).not_to be_blank
      end
    end
  end

  describe 'GET /sign_out' do
    let(:action!) { post :sign_out }
    it_requires 'logged users'

    it "notifies the user" do
      controller.stub(:current_user).and_return('user')
      controller.should_receive(:authenticate!).with(nil)
      action!
      expect(flash[:notice]).not_to be_blank
    end
  end

end

