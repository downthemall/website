class Article < ActiveRecord::Base
  has_ancestry :cache_depth => true
  has_many :translations, :class_name => "ArticleTranslation", :dependent => :destroy, :inverse_of => :article

  scope :sticky, where(:sticky => true)
  scope :popular, order(:views_count => :desc)
  scope :top_five, limit(5)

  validate :at_least_en_translation

  accepts_nested_attributes_for :translations, :allow_destroy => true, :reject_if => lambda { |p| p[:content].blank? && p[:title].blank? && p[:excerpt].blank? }

  def title
    translation_for(I18n.locale).title
  end

  def build_translations
    ArticleTranslation.enabled_locales.each do |locale|
      if translation_for(locale, :include_new_records => true).nil?
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

  def at_least_en_translation
    if translation_for(:en, :include_new_records => true).nil?
      errors.add :base, I18n.t("activerecord.errors.models.article.no_en_translation")
    end
  end

end
