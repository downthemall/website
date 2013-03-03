require 'spec_helper'

describe Article do

  it "requires title" do
    Fabricate.build(:article, title: '').should have_errors_on :title
  end

  it "requires a post date" do
    Fabricate.build(:article, posted_at: '').should have_errors_on :posted_at
  end

  it "requires an author" do
    Fabricate.build(:article, author: nil).should have_errors_on :author
  end

  it "requires a content" do
    Fabricate.build(:article, content: '').should have_errors_on :content
  end

end
