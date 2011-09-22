require 'spec_helper'

describe Article do

  it "throws a validation error if it doesn't have any translation" do
    @article = FactoryGirl.build(:article_with_no_translations)
    @article.should_not be_valid
    @article.errors[:base].should include I18n.t("activerecord.errors.models.article.no_translations")
  end

  it ".translation_for"
end
