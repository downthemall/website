require 'model_spec_helper'

describe Revision do

  it "requires locale" do
    Fabricate.build(:revision, locale: '').should have_errors_on :locale
  end

  it "requires title" do
    Fabricate.build(:revision, title: '').should have_errors_on :title
  end

  it "requires content" do
    Fabricate.build(:revision, content: '').should have_errors_on :content
  end

  it "requires author" do
    Fabricate.build(:revision, author: nil).should have_errors_on :author
  end

  it "requires article" do
    Fabricate.build(:revision, article: nil).should have_errors_on :article
  end

  describe "#pending" do
    it "returns the most recent pending versions" do
      article = Fabricate(:article)
      a = Fabricate(:revision, approved: true, locale: :it, created_at: 4.days.ago, article: article)
      b = Fabricate(:revision, approved: false, locale: :it, created_at: 3.days.ago, article: article)
      c = Fabricate(:revision, approved: false, locale: :it, created_at: 2.days.ago, article: article)
      d = Fabricate(:revision, approved: nil, locale: :en, created_at: 3.days.ago, article: article)
      e = Fabricate(:revision, approved: true, locale: :fr, created_at: 3.days.ago, article: article)

     Revision.pending.should == [ d, c ]
    end
  end

  describe ".status" do
    it "returns the status of a version" do
      article = Fabricate(:article)
      a = Fabricate(:revision, approved: true, locale: :it, created_at: 4.days.ago, article: article)
      b = Fabricate(:revision, approved: false, locale: :it, created_at: 3.days.ago, article: article)
      c = Fabricate(:revision, approved: true, locale: :it, created_at: 2.days.ago, article: article)
      d = Fabricate(:revision, approved: false, locale: :it, created_at: 2.days.ago, article: article)

      a.status.should == Revision::STATUS_APPROVED
      b.status.should == Revision::STATUS_SKIPPED
      c.status.should == Revision::STATUS_PUBLIC
      d.status.should == Revision::STATUS_PENDING
    end
  end

  describe "#build" do
    it "builds a new revision for a new article" do
      user = Fabricate(:user)
      revision = Revision.build("en", user, title: 'Title', category: 'getting-started')
      revision.locale.should == :en
      revision.author.should == user
      revision.title.should == 'Title'
      revision.article.should be_present
      revision.article.should be_new_record
    end
  end

  describe ".build_updated" do
    it "builds a new revision from an existing one" do
      rev = Fabricate(:revision, locale: "en")
      user = Fabricate(:user)
      revision = rev.build_updated(user, title: 'Title')
      revision.locale.should == :en
      revision.author.should == user
      revision.title.should == 'Title'
      revision.article.should == rev.article
    end
  end

  describe ".destroy!" do
    it "destroys the revision (also the article if empty)" do
      revision = Fabricate(:revision)
      article = revision.article
      second_revision = Fabricate(:revision, article: article)

      revision.destroy!
      Article.exists?(article.id).should be_true
      Revision.exists?(revision.id).should be_false

      second_revision.destroy!
      Article.exists?(article.id).should be_false
      Revision.exists?(second_revision.id).should be_false
    end
  end

end
