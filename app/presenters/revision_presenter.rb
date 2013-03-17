# encoding: utf-8
require 'nokogiri'

class RevisionPresenter < BasicPresenter::Base

  def link_to
    context.link_to title, show_url
  end

  def show_url
    context.url(:knowledge_base, :show, id: self)
  end

  def content
    MarkdownFormatter.format(object.content)
  end

  def last_edit
    "Edited #{h.time_ago_in_words(created_at)} ago"
  end

  def author
    object.author.email
  end

  def available_locales
    locales = object.article.available_locales - [ object.locale ]
    if locales.any?
      locales.map! do |locale|
        revision = article.public_revision(locale)
        h.link_to I18n.t("language.#{locale}"), h.url(:knowledge_base, :show, id: revision)
      end.join(", ").html_safe
      "This article is available also in the following locales: #{locales}.".html_safe
    else
      ""
    end
  end

  def actions
    buf = ""
    current_user = context.current_user
    if context.authorized? self, :edit
      buf << context.link_to("Edit", context.url(:knowledge_base, :edit, id: self), class: 'edit')
    end
    if context.authorized? self, :edit
      buf << context.link_to("Translate", context.url(:knowledge_base, :edit, id: self), class: 'translate')
    end
    if context.authorized? self, :destroy
      buf << context.link_to("Delete", context.url(:knowledge_base, :destroy, id: self), class: 'destroy', data: { confirm: 'Are you sure?' })
    end
    if context.authorized?(self, :approve) && !object.approved
      buf << context.link_to("Approve", context.url(:knowledge_base, :approve, id: self), class: 'approve')
    end
    buf
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
      "Pending"
    when Revision::STATUS_PUBLIC
      "Public"
    when Revision::STATUS_APPROVED
      "Approved"
    when Revision::STATUS_SKIPPED
      "Skipped"
    end
  end

end
