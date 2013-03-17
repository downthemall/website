# encoding: utf-8

class ArticlePresenter < BasicPresenter::Base

  def link_to
    context.link_to title, context.url(:knowledge_base, :show, id: public_revision)
  end

  def title
    public_revision.title
  end

  def public_revision
    object.public_revision(I18n.locale)
  end

end
