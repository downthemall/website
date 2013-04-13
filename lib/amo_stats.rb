require 'json'
require 'open-uri'
require 'active_support/core_ext/numeric/time'
require 'active_support/core_ext/date/calculations'
require 'active_support/core_ext/enumerable'
require 'nokogiri'

class AmoStats
  attr_reader :extension

  def initialize(extension)
    @extension = extension
  end

  def avg_daily_users(period = 30)
    date_start = format_date(period.days.ago)
    date_end = format_date(Date.yesterday)
    data = JSON.parse open("https://addons.mozilla.org/en-US/firefox/addon/#{extension}/statistics/usage-day-#{date_start}-#{date_end}.json").read
    counts = data.map do |day|
      day["count"]
    end
    counts.sum / counts.size
  end

  def avg_daily_downloads(period = 30)
    date_start = format_date(period.days.ago)
    date_end = format_date(Date.yesterday)
    data = JSON.parse open("https://addons.mozilla.org/en-US/firefox/addon/#{extension}/statistics/overview-day-#{date_start}-#{date_end}.json").read
    counts = data.map do |day|
      day["data"]["downloads"]
    end
    counts.sum / counts.size
  end

  def total_downloads
    page = Nokogiri::HTML(open("https://addons.mozilla.org/en-US/firefox/addon/downthemall/statistics").read)
    page.at_css("[href='downloads/']").text.gsub(/\D/, '').to_i
  end

  private

  def format_date(date)
    date.to_date.strftime("%Y%m%d")
  end
end

