# encoding: utf-8

class ArticlePresenter < Presenter

  def posted_at
    I18n.l(object.posted_at.to_date, format: :long)
  end

  def posted_at_rss
    object.posted_at.strftime("%a, %d %b %Y %H:%M:%S %z")
  end

  def title_link
    context.link_to title, context.url(:articles, :show, id: self)
  end

  def content
    markdown.render(object.content)
  end

  def markdown
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, space_after_headers: true)
  end

  def actions
    current_user = context.current_user
    if current_user && current_user.admin?
      context.link_to("Edit", context.url(:articles, :edit, id: self)) << " • " <<
      context.link_to("Delete", context.url(:articles, :destroy, id: self), data: { confirm: 'Are you sure?' })
    end
  end

end
