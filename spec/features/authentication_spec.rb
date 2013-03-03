require 'spec_helper'

feature 'Authentication' do

  scenario 'Sign up' do
    visit '/en/sign_up'

    fill_in 'user_email', with: 'foo@bar.org'
    fill_in 'user_password', with: 'password'

    click_button "Sign up"

    page.should have_text 'Signed up correctly!'
  end

  scenario 'Login/Logout' do
    sign_in_as(current_user)
    page.should have_text 'Signed in correctly!'

    visit '/en/sign_out'
    page.should have_text 'Signed out correctly!'
  end

end
