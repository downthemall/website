require 'redcarpet'
require 'nokogiri'
require 'sanitize'

module MarkdownFormatter
  class HTMLWithPants < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants
  end

  def self.format(text)
    process_fenced_notes(text)
    doc_html = "<body>" + markdown.render(text) + "</body>"

    doc = Nokogiri::HTML(doc_html)
    wrap_images(doc)
    convert_notes_to_asides(doc)

    doc = doc.at_css("body").inner_html.strip

    config = Marshal.load(Marshal.dump(Sanitize::Config::RELAXED))
    config[:elements] += [ "aside", "figure", "figcaption" ]
    Sanitize.clean(doc, config)
  end

  def self.process_fenced_notes(text)
    text.gsub! /^!!!\s*$(.*?)^!!!\s*$/m do |match|
      note = markdown.render($1)
      "<div class='note'>#{note}</div>"
    end
  end

  def self.wrap_images(doc)
    doc.css("img").each do |img|
      figure = Nokogiri::XML::Node.new "figure", doc
      img.add_next_sibling(figure)
      figure.add_child(img)

      img.parent = figure

      figcaption = Nokogiri::XML::Node.new "figcaption", doc
      figcaption.inner_html = img['alt']

      img.add_next_sibling(figcaption)
    end
  end

  def self.convert_notes_to_asides(doc)
    doc.css("div.note").each do |div|
      new_node = doc.create_element "aside"
      new_node.inner_html = div.inner_html
      div.replace new_node
    end
  end

  def self.markdown
    @markdown ||= Redcarpet::Markdown.new(
      HTMLWithPants,
      space_after_headers: true,
      fenced_code_blocks: true,
      tables: true,
      no_styles: true,
      hard_wrap: true,
      filter_html: true
    )
  end
end

