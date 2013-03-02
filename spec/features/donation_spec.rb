require 'spec_helper'

feature 'Donations' do
  scenario 'Make donation' do
    visit '/en/donate'
    click_button "Send my donation via PayPal"

    donation = Donation.first
    donation.amount.should == 10
    donation.currency.should == Donation::CURRENCY_USD

    page.should have_button "Proceed"
  end
end
