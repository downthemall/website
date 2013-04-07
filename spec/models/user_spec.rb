require 'model_spec_helper'

describe User do

  it "requires an unique email" do
    expect(Fabricate.build(:user, email: '')).to have_errors_on :email
    expect(Fabricate.build(:user, email: 'foobar')).to have_errors_on :email
    Fabricate(:user, email: 'foobar@email.it')
    expect(Fabricate.build(:user, email: 'foobar@email.it')).to have_errors_on :email
  end

end

