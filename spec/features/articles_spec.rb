require 'spec_helper'

feature 'Articles' do

  scenario 'List articles' do
    Fabricate(:article, title: 'Foo')

    visit '/en/articles'
    page.should have_content 'Foo'
  end

  scenario 'Add article' do
    sign_in_as(current_user(admin: true))

    visit '/en/articles/new'

    fill_in :article_title, with: 'My title'
    fill_in :article_content, with: 'My content'
    fill_in :article_posted_at, with: '2013-12-01'

    click_button 'Create Article'

    page.should have_content 'My title'
    article = Article.first
    article.title.should == 'My title'
  end

end
