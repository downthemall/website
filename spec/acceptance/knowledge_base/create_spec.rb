require 'acceptance/acceptance_helper'

feature 'Knowledge Base Editing', %q{
  In order to improve the userbase of DownThemAll!
  As a website visitor/admin
  I want to be able to create new KB articles
} do

  scenario 'Article creation' do
    # When
    visit new_article_path
    fill :check_box, "Sticky Article?", true
    within "#locale-en" do
      fill :text, "Title", "My Title"
      fill :text, "Content", "My Content"
    end
    click_on "Create Article"

    # Then
    page.should have_notice "Article was successfully created."
    @article = Article.first
    @article.should_not be_nil
    @asticle.should be_sticky
    @article_translation = @article.translation_for(:en)
    @article_translation.should_not be_nil
    @article_translation.title.should == "My Title"
    @article_translation.content.should == "My Content"
  end

end

