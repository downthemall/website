module PaypalLocale
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

  def self.country_code_for_locale(locale)
    PAYPAL_COUNTRYMAP.fetch(locale, 'US')
  end
end

