require 'acceptance/acceptance_helper'

feature 'Knowledge Base Editing', %q{
  In order to improve the userbase of DownThemAll!
  As a website visitor/admin
  I want to be able to manage KB articles
} do

  scenario 'Article creation' do
    # When
    visit new_article_path
    fill :check_box, "Make this article sticky", true
    within "#locale-en" do
      fill :text, "Title", "My Title"
      fill :text, "Content", "My Content"
    end
    click_on "Create Article"

    # Then
    page.should have_notice "Article was successfully created."
    @article = Article.first
    @article.should_not be_nil
    @article.should be_sticky
    @translation = @article.translation_for(:en)
    @translation.should_not be_nil
    @translation.title.should == "My Title"
    @translation.content.should == "My Content"
  end

  scenario 'Article editing' do
    # Given
    @article = FactoryGirl.create(:article)

    # When
    visit article_path(@article)
    fill :check_box, "Make this article sticky", true
    within "#locale-en" do
      fill :text, "Title", "Edited Title"
      fill :text, "Content", "Edited content"
    end
    within "#locale-it" do
      fill :text, "Title", "Titolo modificato"
      fill :text, "Content", "Contenuto modificato"
    end
    click_on "Update Article"
    @article.reload

    # Then
    page.should have_notice "Article was successfully updated."

    @article.should be_sticky

    @en_translation = @article.translation_for(:en)
    @en_translation.title.should == "Edited Title"
    @en_translation.content.should == "Edited content"

    @it_translation = @article.translation_for(:it)
    @it_translation.title.should == "Titolo modificato"
    @it_translation.content.should == "Contenuto modificato"
  end

  scenario 'Article removal' do
    # Given
    @article = FactoryGirl.create(:article)

    # When
    visit edit_article_path(@article)
    click_on "Delete this article"

    # Then
    page.should have_notice "Article was successfully destroyed."
    @article.should_not exist_in_database
  end

end

