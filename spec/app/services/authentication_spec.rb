require 'ostruct'
require 'unit_spec_helper'

class User; end

describe Authentication do

  describe '.authenticate!' do
    it 'raises if email does not exist' do
      User.stub(:find_by_email).with('foo').and_return(nil)
      lambda { Authentication.authenticate!('foo', 'pass') }.should raise_error Authentication::Fail
    end
    it 'raises if digest is incorrect' do
      user = double('User', password_digest: 'digest')
      User.stub(:find_by_email).with('foo').and_return(user)
      Authentication.stub(:check_digest).with('pass', 'digest').and_return(false)
      lambda { Authentication.authenticate!('foo', 'pass') }.should raise_error Authentication::Fail
    end
    it 'passes returning the user otherwise' do
      user = double('User', password_digest: 'digest')
      User.stub(:find_by_email).with('foo').and_return(user)
      Authentication.stub(:check_digest).with('pass', 'digest').and_return(true)
      Authentication.authenticate!('foo', 'pass').should == user
    end
  end

  describe '.create_user' do
    it 'creates a new user, setting up the password digest' do
      user = OpenStruct.new
      User.stub(:new).and_return(user)
      Authentication.stub(:digest).with('password').and_return('digest')
      user = Authentication.create_user('email', 'password')
      user.email.should == 'email'
      user.password.should == 'password'
      user.password_digest.should == 'digest'
    end
  end

  describe 'digest creation/check' do
    example do
      empty_digest = Authentication.digest(nil)
      wrong_digest = Authentication.digest('barfoo')
      digest = Authentication.digest('foobar')
      Authentication.check_digest('foobar', digest).should be_true
      Authentication.check_digest('foobar', empty_digest).should be_false
      Authentication.check_digest('foobar', wrong_digest).should be_false
    end
  end

end
