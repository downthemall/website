class StaticController < ApplicationController
  def homepage
    stats = AmoStats.new(AMO_EXTENSION_ID)
    @total_downloads = cache("dta_total_downloads", expires_in: 6400) { stats.total_downloads }
    @avg_daily_users = cache("dta_avg_daily_users", expires_in: 6400) { stats.avg_daily_users }
    @avg_daily_downloads = cache("dta_avg_daily_downloads", expires_in: 6400) { stats.avg_daily_downloads }
  end

  def features
  end
end

