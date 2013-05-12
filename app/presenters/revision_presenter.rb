# encoding: utf-8
require 'nokogiri'

class RevisionPresenter < Showcase::Presenter

  def link_to
    h.link_to title, show_url
  end

  def show_url
    h.revision_path(self, locale: locale)
  end

  def content
    MarkdownFormatter.format(object.content).html_safe
  end

  def last_edit
    I18n.t('revision.last_edit', time: h.time_ago_in_words(created_at))
  end

  def author
    object.author.email
  end

  def available_locales
    locales = object.article.available_locales - [ object.locale ]
    if locales.any?
      locales = locales.map do |locale|
        revision = article.public_revision(locale)
        h.link_to Locale.new(locale).name, revision
      end.join(", ").html_safe
      I18n.t('revision.available_languages', locales: locales)
    else
      ""
    end
  end

  def actions
    buf = ""
    current_user = h.current_user
    if h.authorized? self, :edit
      buf << h.link_to(I18n.t('revision.actions.edit'), h.edit_revision_path(self), class: 'edit')
    end
    if h.authorized? self, :destroy
      buf << h.link_to(I18n.t('revision.actions.delete'), h.revision_path(self), method: :delete, class: 'destroy', data: { confirm: 'Are you sure?' })
    end
    if h.authorized?(self, :approve) && !object.approved
      buf << h.link_to(I18n.t('revision.actions.approve'), h.approve_revision_path(self), class: 'approve')
    end
    buf.html_safe
  end

  def revision_line
    h.content_tag(:tr) do
      h.content_tag(:th, link_to) <<
      h.content_tag(:td, last_edit) <<
      h.content_tag(:td, status)
    end
  end

  def status
    case object.status
    when Revision::STATUS_PENDING
      I18n.t('revision.status.pending')
    when Revision::STATUS_PUBLIC
      I18n.t('revision.status.public')
    when Revision::STATUS_APPROVED
      I18n.t('revision.status.approved')
    when Revision::STATUS_SKIPPED
      I18n.t('revision.status.skipped')
    end
  end

end

