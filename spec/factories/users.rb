FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "email#{n}@factory.com" }

    trait :admin do
      admin true
    end
  end
end


