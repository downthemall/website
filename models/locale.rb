class Locale < Struct.new(:code)

  PAYPAL_COUNTRYMAP = {
    :'en-GB' => 'GB',
    :'de-CH' => 'CH',
    :'de-AT' => 'AT',
    en: 'US',
    af: 'ZA',
    ar: 'EG',
    ca: 'ES',
    cs: 'CZ',
    cy: 'GB',
    da: 'DK',
    de: 'DE',
    el: 'GR',
    eu: 'BS',
    fa: 'IR',
    fi: 'FI',
    fr: 'FR',
    he: 'IL',
    hu: 'HU',
    id: 'ID',
    it: 'IT',
    ja: 'JP',
    ko: 'KR',
    mn: 'MN',
    nl: 'NL',
    pl: 'PL',
    ro: 'RO',
    ru: 'RU',
    sk: 'SK',
    sq: 'AL',
    sr: 'CS',
    tr: 'TR',
    uk: 'UA',
    vi: 'VI'
  }

  def self.all
    I18n.available_locales.map do |locale|
      Locale.new(locale)
    end
  end

  def self.current
    Locale.new(I18n.locale)
  end

  def paypal_code
    PAYPAL_COUNTRYMAP.fetch(code, 'US')
  end

  def name
    I18n.with_locale(code) do
      I18n.t("language")
    end
  end

  def current?
    I18n.locale == code
  end
end

