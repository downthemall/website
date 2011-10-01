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

  def replace_shortcodes(article, text)
    text.gsub /!image:([^!]*)!/ do
      article_image = article.images.find_by_shortcode($1)
      if article_image.present?
        "!#{article_image.image.url(:medium)}!"
      else
        ""
      end
    end
  end

  def textile(text)
    RedCloth.new(text).to_html
  end

end
