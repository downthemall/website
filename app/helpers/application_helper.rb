module ApplicationHelper

  def form_error_messages(resource)
    if resource.errors.present?
      content_tag :ul, {:class => "form_errors"} do
        resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join.html_safe
      end
    else
      ""
    end
  end

end
