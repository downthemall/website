require 'acceptance/acceptance_helper'

feature 'Home page', %q{
  In order to know better DownThemAll!
  As a website visitor
  I want to be able to head over to the website homepage
} do

  scenario 'Sections Navigation' do
    # When
    visit "/"
    # Then
    within "nav.site-navigation" do
      ["Home", "Getting Started", "Latest News", "Knowledge Base", "Get Involved", "Donate!"].each do |section|
        page.should have_xpath XPath::HTML.link(section)
      end
    end
  end

end
