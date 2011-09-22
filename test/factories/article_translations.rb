# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article_translation do
      article nil
      locale "MyString"
      title "MyString"
      content "MyText"
    end
end
