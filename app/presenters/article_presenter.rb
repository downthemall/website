# encoding: utf-8

class ArticlePresenter < Presenter

  def link_to
    context.link_to public_revision.title, context.url(:knowledge_base, :show, id: public_revision)
  end

  def public_revision
    object.public_revision(I18n.locale)
  end

end
