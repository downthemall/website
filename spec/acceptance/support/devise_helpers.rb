module DeviseHelpers

  def login_as(user)
    visit new_user_session_path
    fill :text, "Email", user.email
    fill :text, "Password", "test123"
    click_on "Log in"
    page.should have_notice "Signed in successfully."
  end

end

RSpec.configuration.include DeviseHelpers, :type => :acceptance



