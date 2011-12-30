require 'acceptance/acceptance_helper'

feature 'Knowledge Base Comments', %q{
  In order to moderate the website discussions
  As a logged-in website admin
  I want to be able to edit and delete unappropriate comments
} do

  scenario 'Registered user comment deletion', :js => true do
    # Given
    @article = FactoryGirl.create(:article)
    @comment = FactoryGirl.create(:comment, :article => @article, :user => FactoryGirl.create(:user))
    @admin = FactoryGirl.create(:admin)
    login_as @admin

     # When
    visit article_path(@article)
    within dom_id_for(@comment) do
      accept_js_confirm do
        click_on "Delete"
      end
    end

    # Then
    page.should have_notice "Comment was successfully destroyed."
    @comment.should_not exist_in_database
  end

  scenario 'Anonymous user comment deletion', :js => true do
    # Given
    @article = FactoryGirl.create(:article)
    @comment = FactoryGirl.create(:anonymous_comment, :article => @article)
    @admin = FactoryGirl.create(:admin)
    login_as @admin

     # When
    visit article_path(@article)
    within dom_id_for(@comment) do
      accept_js_confirm do
        click_on "Delete"
      end
    end

    # Then
    page.should have_notice "Comment was successfully destroyed."
    @comment.should_not exist_in_database
  end

end

