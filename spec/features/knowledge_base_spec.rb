require 'spec_helper'

feature 'Knowledge Base' do
  scenario 'Listing articles' do
    Fabricate(:revision, locale: :en, title: 'Foobar', approved: true)
    visit '/en/knowledge-base'
    page.should have_content 'Foobar'
  end

  scenario 'Adding a new article' do
    Fabricate(:admin, email: 'admin@email.com')

    sign_in_as(Fabricate(:user))
    visit '/en/knowledge-base'
    click_link 'Add new Article'

    fill_in 'revision_title', with: 'Title'
    fill_in 'revision_content', with: 'Content'
    click_button 'Save'

    page.should have_content I18n.t('knowledge_base.created')

    article = Article.first
    article.should have(1).revision

    revision = article.revisions.first
    revision.locale.should == :en
    revision.title.should == 'Title'

    mail = Mail::TestMailer.deliveries.pop
    mail.to.should include 'admin@email.com'
  end

  scenario 'Moderation' do
    sign_in_as(Fabricate(:admin))

    article = Fabricate(:article)
    a = Fabricate(:revision, approved: true, locale: :it, created_at: 4.days.ago, article: article)
    b = Fabricate(:revision, approved: false, locale: :it, created_at: 3.days.ago, article: article)
    c = Fabricate(:revision, approved: true, locale: :it, created_at: 2.days.ago, article: article)
    d = Fabricate(:revision, approved: false, locale: :it, created_at: 2.days.ago, article: article)

    visit "/it/knowledge-base/#{d.id}"
    click_link "Approve"

    d.reload
    d.status.should == Revision::STATUS_PUBLIC

    visit "/it/knowledge-base/#{c.id}"
    click_link "Delete"

    Revision.exists?(c.id).should be_false
  end

  scenario 'Editing' do
    sign_in_as(Fabricate(:user))
    a = Fabricate(:revision, approved: true, locale: :it, created_at: 4.days.ago)

    visit "/it/knowledge-base/#{a.id}"
    click_link "Edit"

    fill_in 'revision_title', with: 'Titolo'
    fill_in 'revision_content', with: 'Contenuto'
    click_button 'Save'

    a.article.should have(2).revisions
    a.article.latest_revision(:it).title.should == 'Titolo'
  end
end

