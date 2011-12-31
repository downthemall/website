require 'acceptance/acceptance_helper'

feature 'Knowledge Base Versioning', %q{
  In order to restore previous versions of an article
  As a website visitor/admin
  I want to be able to browse article change history
} do

  scenario 'Change history' do
    # Given
    @article = FactoryGirl.create(:article)
    @translation = @article.translation_for(:en)

    # When
    @translation.update_attribute(:title, "Edited title")
    @translation.update_attribute(:title, "Re-edited title")

    visit article_path(@article)
    click_on "Change history"

    # Then
    @translation.previous_version.title.should == "Edited title"

    within "ul.versions" do
      page.should have_css("li", :count => 2)
    end

    # When
    click_on "Version 2"

    # Then
    page.should have_css("h1", :text => "Edited title")
  end

end
