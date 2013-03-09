# encoding: utf-8

class RevisionPresenter < Presenter

  def link_to
    context.link_to title, show_url
  end

  def show_url
    context.url(:knowledge_base, :show, id: self)
  end

  def content
    markdown.render(object.content)
  end

  def author
    object.author.email
  end

  def actions
    buf = ""
    current_user = context.current_user
    if context.authorized? self, :edit
      buf << context.link_to("Edit", context.url(:knowledge_base, :edit, id: self))
    end
    if context.authorized? self, :destroy
      buf << context.link_to("Delete", context.url(:knowledge_base, :destroy, id: self), data: { confirm: 'Are you sure?' })
    end
    if context.authorized? self, :approve
      buf << context.link_to("Approve", context.url(:knowledge_base, :approve, id: self))
    end
    buf
  end

  def markdown
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, space_after_headers: true)
  end

  def revision_line
    [ link_to, status ].join(" - ")
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
