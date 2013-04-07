# encoding: utf-8

class ArticlePresenter < Showcase::Presenter

  def link_to
    h.link_to title, h.url(:knowledge_base, :show, id: public_revision)
  end

  def title
    public_revision.title
  end

  def public_revision
    object.public_revision(I18n.locale)
  end

end

