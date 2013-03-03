require 'spec_helper'

describe User do

  it "requires an unique email" do
    Fabricate.build(:user, email: '').should have_errors_on :email
    Fabricate.build(:user, email: 'foobar').should have_errors_on :email
    Fabricate(:user, email: 'foobar@email.it')
    Fabricate.build(:user, email: 'foobar@email.it').should have_errors_on :email
  end

  it "requires a min-6-chars-long password" do
    Fabricate.build(:user, password: 'foo').should have_errors_on :password
  end

end
