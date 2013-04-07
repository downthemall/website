module AutoLocale
  module Helpers
    ##
    # This reload the page changing the I18n.locale
    #
    def switch_to_lang(lang)
      return unless settings.locales.include?(lang)
      if request.path_info[/\/#{I18n.locale}\//]
        request.path_info.sub(/\/#{I18n.locale}\//, "/#{lang}/")
      else
        request.path_info.sub(/\/$/, "/#{lang}")
      end
    end
  end # Helpers

  def self.registered(app)
    app.helpers AutoLocale::Helpers
    app.extend ClassMethods
    app.set :locales, [:en]
    app.before do
      if request.path_info =~ /^\/(#{settings.locales.join('|')})\b/
        I18n.locale = $1.to_sym
      elsif request.env['HTTP_ACCEPT_LANGUAGE']
        # Guess the preferred language from the browser settings
        for browser_locale in request.env['HTTP_ACCEPT_LANGUAGE'].split(",")
          locale, usage = browser_locale.split(";")
          if settings.locales.include?(locale.to_sym)
            I18n.locale = locale.to_sym
            break
          end
        end
        # If none found use the default locale
        I18n.locale ||= settings.locales[0]
      end
    end

    def parse_route(path, options, verb)
      result = super
      path = result.first
      path = "/(:locale)#{path}" unless path.empty?
      result[0] = path
      result
    end
  end

  module ClassMethods
    ##
    # We need to add always a lang to all our routes
    #
    def url(*args)
      params = args.extract_options!
      params[:locale] ||= I18n.locale
      args << params
      super(*args)
    end
  end
end

