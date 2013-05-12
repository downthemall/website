require 'spec_helper'

describe SignIn do
  describe "#find_or_create_user" do
    context "when assertion fails" do
      it "returns nil" do
        Persona.any_instance.stubs(:verify_assertion!).raises(Persona::InvalidResponse)
        expect(SignIn.find_or_create_user('foo', 'bar')).to be_nil
      end
    end
    context "when assertion succeeds" do
      let(:persona) { stubs('Persona') }
      before do
        Persona.stubs(:new).with(audience: 'host').returns(persona)
        persona.stubs(:verify_assertion!).with('XXX').returns(stub(email: 'email'))
      end
      it "returns the user itself" do
        User.stubs(:find_or_create_by_email).with('email').returns('user')
        expect(SignIn.find_or_create_user('XXX', 'host')).to eq 'user'
      end
    end
  end
end

