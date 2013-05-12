# encoding: utf-8

class ArticlePresenter < Showcase::Presenter
  def link_to
    h.link_to title, h.revision_path(public_revision)
  end

  def title
    public_revision.title
  end

  def public_revision
    super(I18n.locale)
  end
end

