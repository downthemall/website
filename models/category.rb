require 'psych'

class Category
  attr_reader :code

  def initialize(code)
    @code = code
  end

  def self.all(yaml_path = Padrino.root('config/kb_categories.yml'))
    @categories = begin
                      codes = Psych.load File.read(yaml_path)
                      codes.map do |code|
                        Category.new(code)
                      end
                    end
  end

  def name
    I18n.t("categories.#{code}")
  end

  def articles
    Article.where(category: code)
  end

  def current_versions(locale)
    articles.map { |a| a.current_version(locale) }.compact
  end

  def pending_versions(locale)
    articles.map { |a| a.pending_version(locale) }.compact
  end

end
