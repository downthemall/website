require 'acceptance/acceptance_helper'

feature 'Knowledge Base Image Editing', %q{
  In order to improve the userbase of DownThemAll!
  As a website visitor/admin
  I want to be able to add images to the KB articles
} do

  scenario 'Image creation', :js => true do
    # Given
    @article = FactoryGirl.create(:article)

    # When
    visit edit_article_path(@article)
    within "section.article-images" do
      click_on "Add image"
      within "#new_article_image" do
        fill :file, "Image", File.join(Rails.root, 'spec/acceptance/files/image.png')
        fill :text, "Shortcode", "mozilla"
        click_on "Create Article image"
      end
    end

    # Then
    page.should have_notice "Article image was successfully created."

    @article.reload

    @article.images.should have(1).image
    @image = @article.images.first

    @image.shortcode.should == "mozilla"

    page.should have_css dom_id_for(@image)
  end

  scenario 'Image edit', :js => true do
    # Given
    @article = FactoryGirl.create(:article_with_image)
    @image = @article.images.first

    # When
    visit edit_article_path(@article)

    find(dom_id_for(@image)).find("a").click

    within "form.article_image" do
      fill :text, "Shortcode", "newcode"
      click_on "Update Article image"
    end

    # Then
    page.should have_notice "Article image was successfully updated."

    @image.reload
    @image.shortcode.should == "newcode"
  end

  scenario 'Image destroy', :js => true do
    # Given
    @article = FactoryGirl.create(:article_with_image)
    @image = @article.images.first

    # When
    visit edit_article_path(@article)

    find(dom_id_for(@image)).find("a").click

    within "form.article_image" do
      accept_js_alert do
        click_on "Delete this image"
      end
    end

    # Then
    page.should have_notice "Article image was successfully destroyed."
    @image.should_not exist_in_database
  end

end
