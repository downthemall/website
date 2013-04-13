Downthemall.controllers do
  get :index do
    stats = AmoStats.new(Downthemall.settings.amo_extension_id)
    @total_downloads = cache("dta_total_downloads", expires_in: 6400) { stats.total_downloads }
    @avg_daily_users = cache("dta_avg_daily_users", expires_in: 6400) { stats.avg_daily_users }
    @avg_daily_downloads = cache("dta_avg_daily_downloads", expires_in: 6400) { stats.avg_daily_downloads }
    render 'static/index'
  end
  get :features do
    render 'static/features'
  end
end

