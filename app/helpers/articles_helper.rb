module ArticlesHelper

  def dom_id_locale(locale)
    "locale-#{locale}"
  end

  def articles_main_content(&block)
    content_tag(:section, :class => "articles") do
      content_tag(:aside) do
        render "articles/sidebar"
      end +
      content_tag(:section, :class => "main-content") do
        capture(&block)
      end
    end
  end

end
