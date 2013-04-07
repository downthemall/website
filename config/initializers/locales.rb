I18n.default_locale = :en
I18n.available_locales = [ :it, :en, :de ]
I18n.backend.class.send(:include, I18n::Backend::Fallbacks)

