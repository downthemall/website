require 'model_spec_helper'

describe Donation do
  it "requires a numeric amount > 1" do
    expect(Fabricate.build(:donation, amount: '')).to have_errors_on :amount
    expect(Fabricate.build(:donation, amount: 'foo')).to have_errors_on :amount
    expect(Fabricate.build(:donation, amount: 0)).to have_errors_on :amount
  end

  it "requires a currency (EUR or USD)" do
    expect(Fabricate.build(:donation, currency: '')).to have_errors_on :currency
    expect(Fabricate.build(:donation, currency: 'YEN')).to have_errors_on :currency
  end

  it "status is an enum" do
    expect(Fabricate.build(:donation, status: nil)).to have_errors_on :status
    expect(Fabricate.build(:donation, status: :foobar)).to have_errors_on :status
    expect(Fabricate.build(:donation, status: Donation::STATUS_PENDING)).not_to have_errors_on :status
  end
end

