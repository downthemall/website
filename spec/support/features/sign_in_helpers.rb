module SignInHelpers
  def sign_in_as(user)
    visit '/en/sign_in'
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button "Sign in"
    page.should have_text 'Signed in correctly!'
  end

  def current_user(attrs = {})
    @current_user ||= Authentication.create_user('foo@bar.org', 'password').tap do |user|
      attrs.each do |k,v|
        user.send("#{k}=", v)
      end
      user.save
    end
  end
end

RSpec.configuration.include SignInHelpers
