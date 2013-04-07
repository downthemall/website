require 'spec_helper'

feature 'Donations' do
  scenario 'Make donation' do
    visit '/en/donate'
    click_button "Donate with PayPal"

    donation = Donation.first
    expect(donation.amount).to eq(10)
    expect(donation.currency).to eq(Donation::CURRENCY_USD)

    expect(page).to have_button "Proceed"
  end
end

