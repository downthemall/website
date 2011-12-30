module FormHelpers

  def fill_captcha
    fill :text, 'Type in the word "captcha", thanks!', 'captcha'
  end

  def fill(type, label, value)
    if type == :select
      select value, :from => label
    elsif type == :text
      fill_in label, :with => value
    elsif type == :date
      select_date value, :from => label
    elsif type == :check_box
      if value
        check label
      else
        uncheck label
      end
    elsif type == :file
      attach_file label, value
    else
      raise RuntimeError, "#{type} type is not known"
    end
  end

  def select_date(date_to_select, options ={})
    date = (date_to_select.is_a?(Date) || date_to_select.is_a?(Time)) ? date_to_select : Date.parse(date_to_select)
    id_prefix = id_prefix_for(options)
    select date.year.to_s, :from => "#{id_prefix}_#{DATE_TIME_SUFFIXES[:year]}"
    select I18n.l(date, :format => :month_name), :from => "#{id_prefix}_#{DATE_TIME_SUFFIXES[:month]}"
    select date.day.to_s, :from => "#{id_prefix}_#{DATE_TIME_SUFFIXES[:day]}"
  end

  def id_prefix_for(options = {})
    msg = "cannot select option, no select box with id, name, or label '#{options[:from]}' found"
    find(:xpath, XPath::HTML.select(options[:from]), msg)[:id].gsub(/_#{DATE_TIME_SUFFIXES[:year]}$/,'')
  end

end

RSpec.configuration.include FormHelpers, :type => :acceptance



