module ApplicationHelper

  def page_id(*args)
    (@_page_id ||= []).concat(args).compact.join(" ")
  end

end
