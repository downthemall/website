require 'spec_helper'

describe Donation do
  it { should_not allow_value('').for(:amount) }
  it { should_not allow_value('foo').for(:amount) }
  it { should_not allow_value(0).for(:amount) }

  it { should_not allow_value('YEN').for(:amount) }
  it { should_not allow_value('').for(:amount) }

  it { should_not allow_value(nil).for(:status) }
  it { should_not allow_value(:foo).for(:status) }
  it { should allow_value(Donation::STATUS_PENDING).for(:status) }
end

