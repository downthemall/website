require 'model_spec_helper'

describe Donation do
  it "requires a numeric amount > 1" do
    Fabricate.build(:donation, amount: '').should have_errors_on :amount
    Fabricate.build(:donation, amount: 'foo').should have_errors_on :amount
    Fabricate.build(:donation, amount: 0).should have_errors_on :amount
  end

  it "requires a currency (EUR or USD)" do
    Fabricate.build(:donation, currency: '').should have_errors_on :currency
    Fabricate.build(:donation, currency: 'YEN').should have_errors_on :currency
  end

  it "status is an enum" do
    Fabricate.build(:donation, status: nil).should have_errors_on :status
    Fabricate.build(:donation, status: :foobar).should have_errors_on :status
    Fabricate.build(:donation, status: Donation::STATUS_PENDING).should_not have_errors_on :status
  end
end
