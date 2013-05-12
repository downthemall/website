module SignInHelpers
  def sign_in_as(user)
    AmoStats.stubs(:new).returns(stub_everything)
    visit "/en/force_sign_in?user_id=#{user.id}"
    expect(page).to have_text 'Signed in correctly!'
  end
end

RSpec.configuration.include SignInHelpers

