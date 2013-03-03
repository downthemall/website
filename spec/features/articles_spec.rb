require 'spec_helper'

feature 'Articles' do

  scenario 'List and read articles' do
    Fabricate(:article, title: 'Foo', content: 'Hey')
    visit '/en/articles'
    page.should have_content 'Foo'
    click_on "Foo"
    page.should have_content 'Hey'
  end

  scenario 'RSS Feed' do
    visit '/en/articles.rss'
    page.response_headers['Content-Type'].should =~ /rss/
  end

  scenario 'Add article' do
    sign_in_as(current_user(admin: true))

    visit '/en/articles/new'

    fill_in :article_title, with: 'My title'
    fill_in :article_content, with: 'My content'
    fill_in :article_posted_at, with: '2013-12-01'
    click_button 'Save'
    page.should have_content 'My title'
    article = Article.first
    article.title.should == 'My title'
  end

  scenario 'Edit article' do
    Fabricate(:article, title: 'Foo', content: 'Hey')
    sign_in_as(current_user(admin: true))
    visit '/en/articles/1/edit'
    fill_in :article_title, with: 'My title'
    click_button 'Save'
    page.should have_content 'My title'
    article = Article.first
    article.title.should == 'My title'
  end

end
