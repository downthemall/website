require 'spec_helper'

describe Post do

  it "requires title" do
    Fabricate.build(:post, title: '').should have_errors_on :title
  end

  it "requires a post date" do
    Fabricate.build(:post, posted_at: '').should have_errors_on :posted_at
  end

  it "requires an author" do
    Fabricate.build(:post, author: nil).should have_errors_on :author
  end

  it "requires a content" do
    Fabricate.build(:post, content: '').should have_errors_on :content
  end

end
