require 'presenter'
require 'auto_locale'
require 'will_paginate'
require 'will_paginate/active_record'
require 'rack-flash'
require 'mail'
require 'letter_opener'

class Downthemall < Padrino::Application
  use ActiveRecord::ConnectionAdapters::ConnectionManagement

  register Padrino::Rendering
  register Padrino::Mailer
  register Padrino::Helpers
  register Padrino::AutoLocale
  register WillPaginate::Sinatra
  register StraightAuth

  use Rack::Flash, sweep: true

  register Padrino::Sprockets
  sprockets minify: (Padrino.env == :production)

  set :locales, [:en, :it, :de]

  enable :sessions

  module Helpers
    include Presenter::Helpers
  end

  helpers do
    include Helpers
    include Pundit
  end

  configure :development, :test do
    set :host, "http://downthemall.dev"
    set :paypal_account, "vendo_1321197264_biz@gmail.com"
    set :paypal_url, "https://www.sandbox.paypal.com/cgi-bin/webscr"
    ActiveMerchant::Billing::Base.mode = :test
  end

  configure :development do
    set :delivery_method, LetterOpener::DeliveryMethod
    Mail.defaults do
      delivery_method LetterOpener::DeliveryMethod, location: File.expand_path('../tmp/letter_opener', __FILE__)
    end

    error do
      exception = env['sinatra.error']
      CGI::escapeHTML(exception.message) + "<br/>"*2 + exception.backtrace.join("<br/>")
    end
  end

  configure :test do
    set :delivery_method, :test
  end

  configure :production do
    set :host, "http://www.downthemall.net"
    set :paypal_account, "donors@downthemall.net"
    set :paypal_url, "https://www.paypal.com/cgi-bin/webscr"
  end

  error StraightAuth::AuthenticatedUserRequired do
    flash[:alert] = I18n.t('authentication.must_be_signed_in')
    redirect url(:index)
  end

  error StraightAuth::UnauthenticatedUserRequired do
    flash[:alert] = I18n.t('authentication.already_signed_in')
    redirect url(:index)
  end

  error Pundit::NotAuthorizedError do
    flash[:alert] = I18n.t('authorization.forbidden')
    redirect url(:index)
  end

  set :show_exceptions, false
end

Mail::Message.class_eval do
  include Padrino::Helpers::OutputHelpers
  include Padrino::Helpers::TagHelpers
  include Padrino::Helpers::AssetTagHelpers
  def url(*args)
    File.join(Downthemall.settings.host, Downthemall.url(*args))
  end
end

module Padrino
  module Helpers
    module FormHelpers
      def datetime_local_field_tag(name, options)
        if options[:value]
          options[:value] = options[:value].try(:to_datetime).try(:strftime, "%Y-%m-%dT%H:%M")
        end
        input_tag(:"datetime-local", options.reverse_merge!(name: name))
      end
    end
    module FormBuilder
      class AbstractFormBuilder
        def datetime_local_field(field, options={})
          options.reverse_merge!(:value => field_value(field), :id => field_id(field))
          options.merge!(:class => field_error(field, options))
          @template.datetime_local_field_tag field_name(field), options
        end
      end
    end
    module AssetTagHelpers
      def asset_folder_name(kind)
        case kind
        when :css then 'assets'
        when :js  then 'assets'
        else kind.to_s
        end
      end

      alias_method :old_asset_timestamp, :asset_timestamp
      def asset_timestamp(file_path, absolute=false)
        if file_path.to_s =~ /.js$/
          ""
        else
          old_asset_timestamp(file_path, absolute)
        end
      end
    end
  end
end
