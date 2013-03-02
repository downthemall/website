require 'spec_helper'

describe User do

  it "requires an unique email" do
    factory.user(email: '').should have_at_least(1).error_on :email
    factory.user(email: 'foobar').should have_at_least(1).error_on :email

    factory.user!(email: 'foobar@email.it')
    factory.user(email: 'foobar@email.it').should have_at_least(1).error_on :email
  end

  it "requires a min-6-chars-long password" do
    factory.user(password: 'foo').should have_at_least(1).error_on :password
  end

end
