class ArticlePresenter < Presenter

  def posted_at
    I18n.l(object.posted_at.to_date, format: :long)
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

end
