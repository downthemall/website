unless Rails.env.production?
  Localeapp.configure do |config|
    config.api_key                    = 'DFMisQz08o3dMeqdbfYKVX4Xrf4hUKX4suDH0x5eP03fKL31XK'
    config.translation_data_directory = 'config/locales'
    config.synchronization_data_file  = '.localeapp/log.yml'
    config.daemon_pid_file            = '.localeapp/localeapp.pid'
  end
end

