require 'spec_helper'

feature 'Knowledge Base' do
  scenario 'Listing articles' do
    create(:revision, locale: :en, title: 'Foobar', approved: true)
    visit '/en/knowledge-base'
    expect(page).to have_content 'Foobar'
  end

  scenario 'Adding a new article' do
    create(:user, :admin, email: 'admin@email.com')
    sign_in_as(create(:user))

    visit '/en/knowledge-base/new'

    fill_in 'revision_title', with: 'Title'
    fill_in 'revision_content', with: 'Content'
    click_button 'Save'

    expect(page).to have_content I18n.t('knowledge_base.created')

    article = Article.first
    expect(article).to have(1).revision

    revision = article.revisions.first
    expect(revision.locale).to eq(:en)
    expect(revision.title).to eq('Title')

    mail = Mail::TestMailer.deliveries.pop
    expect(mail.to).to include 'admin@email.com'
  end

  scenario 'Translate an article' do
    create(:user, :admin, email: 'admin@email.com')

    revision = create(:revision, locale: :en, title: 'Article', approved: true)
    sign_in_as(create(:user))

    visit "/en/knowledge-base/#{revision.to_param}"
    click_link "Edit/Translate"

    select 'Italiano', from: 'Language'
    fill_in 'revision_title', with: 'Titolo'
    fill_in 'revision_content', with: 'Contenuto'
    click_button 'Save'

    I18n.with_locale(:en) do
      expect(page).to have_content I18n.t('knowledge_base.updated')
    end

    revision = revision.article.latest_revision(:it)
    expect(revision.locale).to eq(:it)
    expect(revision.title).to eq('Titolo')

    mail = Mail::TestMailer.deliveries.pop
    expect(mail.to).to include 'admin@email.com'
  end

  scenario 'Moderation' do
    sign_in_as(create(:user, :admin))

    article = create(:article)
    a = create(:revision, approved: true, locale: :en, created_at: 4.days.ago, article: article)
    b = create(:revision, approved: false, locale: :en, created_at: 3.days.ago, article: article)
    c = create(:revision, approved: true, locale: :en, created_at: 2.days.ago, article: article)
    d = create(:revision, approved: false, locale: :en, created_at: 2.days.ago, article: article)

    visit "/en/knowledge-base/#{d.id}"
    click_link "Approve"

    d.reload
    expect(d.status).to eq(Revision::STATUS_PUBLIC)

    visit "/en/knowledge-base/#{c.id}"
    click_link "Delete"

    expect(Revision.exists?(c.id)).to be_false
  end

  scenario 'Editing' do
    sign_in_as(create(:user))
    a = create(:revision, approved: true, locale: :en, created_at: 4.days.ago)

    visit "/en/knowledge-base/#{a.id}"
    click_link "Edit/Translate"

    fill_in 'revision_title', with: 'Foo'
    fill_in 'revision_content', with: 'Bar'
    click_button 'Save'

    expect(a.article).to have(2).revisions
    expect(a.article.latest_revision(:it).title).to eq('Foo')
  end
end

