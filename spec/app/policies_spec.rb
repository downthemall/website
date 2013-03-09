require 'unit_spec_helper'

describe "System policies", type: :policy do

  let(:user) { double('User', admin?: false) }
  let(:admin) { double('User', admin?: true) }

  describe PostPolicy do
    let(:post) { double('Post') }

    it { should_not permit(nil, post, :new?, :create?, :update?, :destroy?) }
    it { should_not permit(user, post, :new?, :create?, :update?, :destroy?) }
    it { should permit(admin, post, :new?, :create?, :update?, :destroy?) }
  end

  describe RevisionPolicy do
    let(:post) { double('Revision', author: 'foo') }
    let(:my_approved_post) { double('Revision', author: user, approved: true) }
    let(:my_post) { double('Revision', author: user, approved: false) }

    it { should_not permit(nil, post, :new?, :create?, :update?, :destroy?, :approve?) }
    it { should permit(user, post, :new?, :create?, :update?) }
    it { should_not permit(user, post, :destroy?, :approve?) }
    it { should permit(user, my_post, :destroy?) }
    it { should_not permit(user, my_approved_post, :destroy?) }
    it { should permit(admin, my_approved_post, :new?, :create?, :update?, :destroy?, :approve?) }
  end

end
