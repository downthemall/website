require 'spec_helper'

describe Article do

  it "throws a validation error if it doesn't have :en translation" do
    @article = FactoryGirl.build(:article_with_no_translations)
    @article.should_not be_valid
    @article.errors[:base].should include I18n.t("activerecord.errors.models.article.no_en_translation")
  end

  describe ".translation_for" do
    subject {
      article = FactoryGirl.create(:article)
      article.translations.build(:locale => :de)
      article
    }
    context "with no options" do
      it "should not find new records" do
        subject.translation_for(:en).should_not be_nil
        subject.translation_for(:de).should be_nil
      end
    end
    context "with :include_new_records => true" do
      it "should find new records" do
        subject.translation_for(:en, :include_new_records => true).should_not be_nil
        subject.translation_for(:de, :include_new_records => true).should_not be_nil
      end
    end
  end
end
