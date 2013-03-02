require 'authentication'
require 'amo_helpers'
require 'auto_locale'

class Downthemall < Padrino::Application
  use ActiveRecord::ConnectionAdapters::ConnectionManagement
  register Padrino::Rendering
  register Padrino::Mailer
  register Padrino::Helpers
  register Padrino::AutoLocale

  register Padrino::Sprockets
  sprockets minify: (Padrino.env == :production)

  set :locales, [:en, :it, :de]

  enable :sessions

  module Helpers
    include Authentication::Helpers
    include AmoHelpers
  end

  helpers do
    include Helpers
  end

  configure :development, :test do
    set :paypal_account, "vendo_1321197264_biz@gmail.com"
    set :paypal_url, "https://www.sandbox.paypal.com/cgi-bin/webscr"
    ActiveMerchant::Billing::Base.mode = :test
  end

  configure :production do
    set :paypal_account, "donors@downthemall.net"
    set :paypal_url, "https://www.paypal.com/cgi-bin/webscr"
  end

  ##
  # Caching support
  #
  # register Padrino::Cache
  # enable :caching
  #
  # You can customize caching store engines:
  #
  #   set :cache, Padrino::Cache::Store::Memcache.new(::Memcached.new('127.0.0.1:11211', exception_retry_limit: 1))
  #   set :cache, Padrino::Cache::Store::Memcache.new(::Dalli::Client.new('127.0.0.1:11211', exception_retry_limit: 1))
  #   set :cache, Padrino::Cache::Store::Redis.new(::Redis.new(host: '127.0.0.1', port: 6379, db: 0))
  #   set :cache, Padrino::Cache::Store::Memory.new(50)
  #   set :cache, Padrino::Cache::Store::File.new(Padrino.root('tmp', app_name.to_s, 'cache')) # default choice
  #

  ##
  # Application configuration options
  #
  # set :raise_errors, true       # Raise exceptions (will stop application) (default for test)
  # set :dump_errors, true        # Exception backtraces are written to STDERR (default for production/development)
  # set :show_exceptions, true    # Shows a stack trace in browser (default for development)
  # set :logging, true            # Logging in STDOUT for development and file for production (default only for development)
  # set :public_folder, "foo/bar" # Location for static assets (default root/public)
  # set :reload, false            # Reload application files (default in development)
  # set :default_builder, "foo"   # Set a custom form builder (default 'StandardFormBuilder')
  # set :locale_path, "bar"       # Set path for I18n translations (default your_app/locales)
  # disable :sessions             # Disabled sessions by default (enable if needed)
  # disable :flash                # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
  # layout  :my_layout            # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
  #

  ##
  # You can configure for a specified environment like:
  #
  #   configure :development do
  #     set :foo, :bar
  #     disable :asset_stamp # no asset timestamping for dev
  #   end
  #

  ##
  # You can manage errors like:
  #
  #   error 404 do
  #     render 'errors/404'
  #   end
  #
  #   error 505 do
  #     render 'errors/505'
  #   end
  #
end

module Padrino
  module Helpers
    module AssetTagHelpers
      def asset_folder_name(kind)
        case kind
        when :css then 'assets'
        when :js  then 'assets'
        else kind.to_s
        end
      end

      def asset_timestamp(file_path, absolute=false)
        ""
      end
    end
  end
end
