# encoding: utf-8

class PostPresenter < BasicPresenter::Base

  def posted_at
    I18n.l(object.posted_at.to_date, format: :long)
  end

  def posted_at_rss
    object.posted_at.strftime("%a, %d %b %Y %H:%M:%S %z")
  end

  def title_link
    context.link_to title, context.url(:posts, :show, id: self)
  end

  def content
    MarkdownFormatter.format(object.content)
  end

  def actions
    if context.authorized?(self, :edit)
      context.link_to("Edit", context.url(:posts, :edit, id: self), class: "edit") <<
      context.link_to("Delete", context.url(:posts, :destroy, id: self), class: "destroy", data: { confirm: 'Are you sure?' })
    end
  end

end
