module MarkdownFormatter

  class HTMLWithPants < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants
  end

  def self.format(text)
    markdown = Redcarpet::Markdown.new(HTMLWithPants, space_after_headers: true, fenced_code_blocks: true, tables: true)

    text.gsub! /^!!!\s*$(.*?)^!!!\s*$/m do |match|
      note = markdown.render($1)
      "<div class='note'>#{note}</div>"
    end

    doc = Nokogiri::HTML(markdown.render(text))
    doc.css("img").each do |img|
      figure = Nokogiri::XML::Node.new "figure", doc
      img.add_next_sibling(figure)
      figure.add_child(img)

      img.parent = figure

      figcaption = Nokogiri::XML::Node.new "figcaption", doc
      figcaption.inner_html = img['alt']

      img.add_next_sibling(figcaption)
    end

    doc.to_html
  end
end
