require 'spec_helper'

feature 'Posts' do
  scenario 'List and read posts' do
    create(:post, title: 'Foo', content: 'Hey')
    visit '/en/news'
    expect(page).to have_content 'Foo'
    click_on "Foo"
    expect(page).to have_content 'Hey'
  end

  scenario 'RSS Feed' do
    visit '/en/news.rss'
    expect(page.response_headers['Content-Type']).to match(/rss/)
  end

  scenario 'Add post' do
    sign_in_as(create(:user, :admin))
    visit '/en/news/new'
    fill_in :post_title, with: 'My title'
    fill_in :post_content, with: 'My content'
    fill_in :post_posted_at, with: '2013-12-01'
    click_button 'Save'
    expect(page).to have_content 'My title'
    post = Post.first
    expect(post.title).to eq('My title')
  end

  scenario 'Edit post' do
    post = create(:post, title: 'Foo', content: 'Hey')
    sign_in_as(create(:user, :admin))
    visit "/en/news/#{post.to_param}/edit"
    fill_in :post_title, with: 'My title'
    click_button 'Save'
    expect(page).to have_content 'My title'
    post.reload
    expect(post.title).to eq('My title')
  end
end

