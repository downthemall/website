require 'mail'

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
        when :images then 'assets'
        else kind.to_s
        end
      end
    end
  end
end

