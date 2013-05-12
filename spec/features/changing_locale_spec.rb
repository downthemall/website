require 'spec_helper'

feature 'Changing locale' do
  scenario 'User changes locale' do
    AmoStats.stub(:new).and_return(stub.as_null_object)

    visit '/en'
    I18n.with_locale(:en) do
      expect(page).to have_content I18n.t('homepage.title')
    end

    click_link "Italiano"
    I18n.with_locale(:it) do
      expect(page).to have_content I18n.t('homepage.title')
    end
  end
end

