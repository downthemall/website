module FlashMessageHelpers

  def have_notice(message)
    xpath = XPath.generate do |x|
      x.descendant(:div)[ x.attr(:class).contains('flash-message') & x.attr(:class).contains('notice') & x.contains(message)]
    end
    Capybara::RSpecMatchers::HaveMatcher.new(:xpath, xpath.to_xpath)
  end

  def have_alert(message)
    xpath = XPath.generate do |x|
      x.descendant(:div)[ x.attr(:class).contains('flash-message') & x.attr(:class).contains('alert') & x.contains(message)]
    end
    Capybara::RSpecMatchers::HaveMatcher.new(:xpath, xpath.to_xpath)
  end

end

RSpec.configuration.include FlashMessageHelpers, :type => :acceptance
