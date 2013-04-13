Downthemall.controllers do
  get :index do
    stats = AmoStats.new(Downthemall.settings.amo_extension_id)
    @total_downloads = cache("amo_total_downloads", expires_in: 1.day) { stats.total_downloads }
    @avg_daily_users = cache("amo_avg_daily_downloads", expires_in: 1.day) { stats.avg_daily_users }
    @avg_daily_downloads = cache("amo_avg_daily_downloads", expires_in: 1.day) { stats.avg_daily_downloads }
    render 'static/index'
  end
  get :features do
    render 'static/features'
  end
end

