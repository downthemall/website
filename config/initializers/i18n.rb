# config/initializers/i18n.rb
module I18n
  def self.name_for_locale(locale)
    begin
      I18n.translate("meta.language_name.#{locale}")
    rescue I18n::MissingTranslationData
      locale.to_s
    end
  end
end
