class Locale < Struct.new(:code)
  def self.all
    I18n.available_locales.map do |locale|
      Locale.new(locale)
    end
  end

  def name
    I18n.t "language.#{code}"
  end
end

