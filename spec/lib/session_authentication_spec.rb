require "unit_spec_helper"

class User
end

describe SessionAuthentication do

  describe SessionAuthentication::Helpers do
    let(:controller) { Object.new.tap {|o| o.extend SessionAuthentication::Helpers } }
    let(:user) { double('User', id: 'ID') }

    describe "require_non_signed_in_user!" do
      it "raises error if signed in" do
        controller.stub(:current_user).and_return('user')
        expect { controller.require_non_signed_in_user! }.to raise_error(SessionAuthentication::UnauthenticatedUserRequired)
      end
    end

    describe "require_signed_in_user!" do
      it "raises error if not signed in" do
        controller.stub(:current_user).and_return(nil)
        expect { controller.require_signed_in_user! }.to raise_error(SessionAuthentication::AuthenticatedUserRequired)
      end
    end

    describe '.authenticate!' do
      let(:session) { Hash.new }
      before do
        controller.stub(:session).and_return(session)
      end

      context 'when user is nil' do
        it 'clears the session' do
          controller.authenticate!(nil)
          expect(session[:user_id]).to be_nil
        end
      end

      context 'when the user esists' do
        it 'sets the user id inside session' do
          controller.authenticate!(user)
          expect(session[:user_id]).to eq 'ID'
        end
      end
    end

  end
end

