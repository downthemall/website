require 'spec_helper'

describe Post do
  it { should_not allow_value('').for(:title) }
  it { should_not allow_value('').for(:posted_at) }
  it { should_not allow_value(nil).for(:author) }
  it { should_not allow_value('').for(:content) }
end

