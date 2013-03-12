require 'model_spec_helper'

describe Article do

  it "requires a category" do
    expect(Fabricate.build(:article, category: '')).to have_errors_on :category
  end

  describe "#latest_revision and #public_revision" do
    it "returns the latest revision available for a locale" do
      a = Fabricate(:article)
      recent_revision = Fabricate(:revision, approved: false, locale: :it, created_at: 2.days.ago, article: a)
      old_revision    = Fabricate(:revision, approved: true, locale: :it, created_at: 3.days.ago, article: a)

      expect(a.latest_revision(:it)).to eq(recent_revision)
      expect(a.public_revision(:it)).to eq(old_revision)
    end
  end

  describe "#with_public_revisions" do
    it "returns only articles with at least an approved revision" do
      article = Fabricate(:article)
      Fabricate(:revision, approved: true, locale: :it, article: article)
      Fabricate(:revision, approved: true, locale: :it, created_at: 3.days.ago, article: article)
      Fabricate(:revision, approved: false, locale: :en, article: article)

      expect(Article.with_public_revisions(:it)).to eq([ article ])
      expect(Article.with_public_revisions(:fr)).to be_empty
      expect(Article.with_public_revisions(:en)).to be_empty
    end
  end

end
