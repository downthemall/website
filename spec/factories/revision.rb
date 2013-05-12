FactoryGirl.define do
  factory :revision do
    locale :it
    title 'Foobar'
    content 'Lorem'
    association :author, factory: :user
    article
  end
end

