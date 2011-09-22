# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :article do
    translations { FactoryGirl.build_list(:article_translation, 1) }
  end

  factory :article_with_no_translations, :class => :article do
    translations { Array.new }
  end

  factory :sticky_article, :parent => :article do
    sticky true
  end

  factory :article_translation do
    locale            "en"
    sequence(:title)  { |n| "Article #{i}" }
    content           "That's some content"
  end

end
