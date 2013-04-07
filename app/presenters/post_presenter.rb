# encoding: utf-8

class PostPresenter < Showcase::Presenter

  def posted_at
    I18n.l(object.posted_at.to_date, format: :long)
  end

  def posted_at_rss
    object.posted_at.strftime("%a, %d %b %Y %H:%M:%S %z")
  end

  def title_link
    h.link_to title, h.url(:posts, :show, id: self)
  end

  def content
    MarkdownFormatter.format(object.content)
  end

  def actions
    if h.authorized?(self, :edit)
      h.link_to(I18n.t('post.actions.edit'), h.url(:posts, :edit, id: self), class: "edit") <<
      h.link_to(I18n.t('post.actions.delete'), h.url(:posts, :destroy, id: self), class: "destroy", data: { confirm: 'Are you sure?' })
    end
  end

end

