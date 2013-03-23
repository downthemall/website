Fabricator(:user) do
  email { sequence(:email) { |i| "user#{i}@example.com" } }
end

Fabricator(:admin, from: :user) do
  admin true
end

Fabricator(:donation) do
  amount 5
  status Donation::STATUS_PENDING
  currency Donation::CURRENCY_USD
end

Fabricator(:post) do
  title "Title"
  posted_at Time.now
  content "Lorem"
  author { Fabricate.build(:user) }
end

Fabricator(:article) do
  category "tutorials"
end

Fabricator(:revision, class_name: Revision) do
  locale :it
  title 'Foobar'
  content 'Lorem'
  author { Fabricate.build(:user) }
  article
end
