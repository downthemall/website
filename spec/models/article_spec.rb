require 'model_spec_helper'

describe Article do

  it "requires a category" do
    Fabricate.build(:article, category: '').should have_errors_on :category
  end

  describe "#latest_revision and #public_revision" do
    it "returns the latest revision available for a locale" do
      a = Fabricate(:article)
      recent_revision = Fabricate(:revision, approved: false, locale: :it, created_at: 2.days.ago, article: a)
      old_revision    = Fabricate(:revision, approved: true, locale: :it, created_at: 3.days.ago, article: a)

      a.latest_revision(:it).should == recent_revision
      a.public_revision(:it).should == old_revision
    end
  end

  describe "#with_public_revisions" do
    it "returns only articles with at least an approved revision" do
      article = Fabricate(:article)
      Fabricate(:revision, approved: true, locale: :it, article: article)
      Fabricate(:revision, approved: true, locale: :it, created_at: 3.days.ago, article: article)
      Fabricate(:revision, approved: false, locale: :en, article: article)

      Article.with_public_revisions(:it).should == [ article ]
      Article.with_public_revisions(:fr).should be_empty
      Article.with_public_revisions(:en).should be_empty
    end
  end

end
