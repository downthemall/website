require 'model_spec_helper'

describe Post do

  it "requires title" do
    expect(Fabricate.build(:post, title: '')).to have_errors_on :title
  end

  it "requires a post date" do
    expect(Fabricate.build(:post, posted_at: '')).to have_errors_on :posted_at
  end

  it "requires an author" do
    expect(Fabricate.build(:post, author: nil)).to have_errors_on :author
  end

  it "requires a content" do
    expect(Fabricate.build(:post, content: '')).to have_errors_on :content
  end

end
