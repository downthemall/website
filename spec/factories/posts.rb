FactoryGirl.define do
  factory :post do
    title "Title"
    posted_at Time.now
    content "Lorem"
    association :author, factory: :user
  end
end

