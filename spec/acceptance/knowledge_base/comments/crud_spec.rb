require 'acceptance/acceptance_helper'

feature 'Knowledge Base Comments', %q{
  In order to ask and reply to DTA-related questions
  As a website visitor/admin
  I want to be able to add comments to KB articles
} do

  scenario 'Comment creation', :js => true do
    # Given
    @article = FactoryGirl.create(:article)

    # When
    visit article_path(@article)
    click_on "Add a new comment"
    fill :text, "Your name", "Stefano Verna"
    fill :text, "Your email", "stefano.verna@welaika.com"
    fill :text, "Your comment", "That's my comment"
    fill_captcha_correctly
    click_on "Submit comment"

    # Then
    page.should have_notice "Comment was successfully created."

    @comment = @article.comments.first
    @comment.should_not be_nil
    @comment.author_name.should == "Stefano Verna"
    @comment.author_email.should == "stefano.verna@welaika.com"
    @comment.content.should == "That's my comment"

    page.should have_css dom_id_for(@comment)
  end

  scenario 'Comment editing', :js => true do
    # Given
    @article = FactoryGirl.create(:article)
    @comment = FactoryGirl.create(:comment, :article => @article)

    # When
    visit article_path(@article)
    within dom_id_for(@comment) do
      click_on "Edit"
    end

    fill :text, "Your name", "Stefano Verna"
    fill :text, "Your email", "stefano.verna@welaika.com"
    fill :text, "Your comment", "That's my comment"
    fill_captcha_correctly
    click_on "Update comment"

    # Then
    page.should have_notice "Comment was successfully updated."

    @comment.reload
    @comment.author_name.should == "Stefano Verna"
    @comment.author_email.should == "stefano.verna@welaika.com"
    @comment.content.should == "That's my comment"

    within dom_id_for(@comment) do
      page.should have_content "Stefano Verna"
      page.should have_content "stefano.verna@welaika.com"
      page.should have_content "That's my comment"
    end
  end

  scenario 'Comment removal', :js => true do
    # Given
    @article = FactoryGirl.create(:article)
    @comment = FactoryGirl.create(:comment, :article => @article)

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


