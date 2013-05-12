FactoryGirl.define do
  factory :donation do
    amount 5
    status Donation::STATUS_PENDING
    currency Donation::CURRENCY_USD
  end
end



