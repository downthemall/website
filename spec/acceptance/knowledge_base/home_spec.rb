require 'acceptance/acceptance_helper'

feature 'Knowledge Base Home', %q{
  In order to know better DownThemAll!
  As a website visitor
  I want to be able to navigate throught the KB documentation
} do

  scenario 'Sticky Articles' do
    # Given
    @article = FactoryGirl.create(:sticky_article)
    # When
    visit articles_path
    # Then
    within "section.sticky-articles" do
      page.should have_css dom_id_for(@article)
    end
  end

end
