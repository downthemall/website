require 'model_spec_helper'

describe SignIn do
  describe "#find_or_create_user" do
    context "when assertion fails" do
      it "returns nil" do
        Persona.any_instance.stub(:verify_assertion!).and_raise(Persona::InvalidResponse)
        expect(SignIn.find_or_create_user('foo', 'bar')).to be_nil
      end
    end
    context "when assertion succeeds" do
      let(:persona) { stub('Persona') }
      before do
        Persona.stub(:new).with(audience: 'host').and_return(persona)
        persona.stub(:verify_assertion!).with('XXX').and_return(stub(email: 'email'))
      end
      it "returns the user itself" do
        User.stub(:find_or_create_by_email).with('email').and_return('user')
        expect(SignIn.find_or_create_user('XXX', 'host')).to eq 'user'
      end
    end
  end
end

