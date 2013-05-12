require 'spec_helper'

describe User do
  it { should_not allow_value('').for(:email) }
  it { should validate_uniqueness_of(:email) }
end

