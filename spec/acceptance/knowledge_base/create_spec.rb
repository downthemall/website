require 'acceptance/acceptance_helper'

feature 'Knowledge Base Editing', %q{
  In order to improve the userbase of DownThemAll!
  As a website visitor/admin
  I want to be able to create new KB articles
} do

  scenario 'Article creation' do
    visit new_article_path
    save_and_open_page
    fill :check_box, "Sticky Article?", true
    click_on "Create Article"
  end

end

