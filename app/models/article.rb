class Article < ActiveRecord::Base
  has_ancestry :orphan_strategy => :restrict, :cache_depth => true
  has_many :translations, :class_name => "ArticleTranslation", :dependent => :destroy, :inverse_of => :article

  scope :sticky, where(:sticky => true)

  validate :at_least_a_translation

  accepts_nested_attributes_for :translations, :allow_destroy => true, :reject_if => lambda { |p| p[:content].blank? && p[:title].blank? && p[:excerpt].blank? }

  def title
    translation_for(I18n.locale).title
  end

  def build_translations
    ArticleTranslation.enabled_locales.each do |locale|
      if translation_for(locale).nil?
        translations.build(:locale => locale.to_s)
      end
    end
  end

  def translation_for(locale, *args)
    options = args.extract_options!
    if options[:include_new_records]
      translations.detect { |translation| translation.locale.to_s == locale.to_s }
    else
      translations.with_locale(locale).first
    end
  end

  private

  def at_least_a_translation
    if translations.size.zero?
      errors.add :base, I18n.t("activerecord.errors.models.article.no_translations")
    end
  end

end
