Fabricator(:user) do
  email { sequence(:email) { |i| "user#{i}@example.com" } }
  password 'foobar123'
end

Fabricator(:donation) do
  amount 5
  status Donation::STATUS_PENDING
  currency Donation::CURRENCY_USD
end

Fabricator(:article) do
  title "Title"
  posted_at Time.now
  content "Lorem"
  author { Fabricate.build(:user) }
end
