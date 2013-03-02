require 'spec_helper'

describe Donation do
  it "requires a numeric amount > 1" do
    factory.donation(amount: '').should have_at_least(1).error_on :amount
    factory.donation(amount: 'foo').should have_at_least(1).error_on :amount
    factory.donation(amount: 0).should have_at_least(1).error_on :amount
  end

  it "requires a currency (EUR or USD)" do
    factory.donation(currency: '').should have_at_least(1).error_on :currency
    factory.donation(currency: 'YEN').should have_at_least(1).error_on :currency
  end

  it "status is an enum" do
    factory.donation(status: nil).should have_at_least(1).error_on :status
    factory.donation(status: :foobar).should have_at_least(1).error_on :status
    factory.donation(status: Donation::STATUS_PENDING).should_not have_at_least(1).error_on :status
  end
end
