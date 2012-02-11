# encoding: utf-8
#
class Donation < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :amount

  def formatted_amount
    currency_symbols = { 'EUR' => '€', 'USD' => '$' }
    "#{currency_symbols[currency]}#{amount.to_i}"
  end

  def share_text
    donation_amount = Donation.amounts.find do |donation_amount|
      donation_amount.amount == amount
    end
    if donation_amount.present?
      "I just donated #{formatted_amount} (#{donation_amount.description}) to DownThemAll devs!"
    else
      "I just donated #{formatted_amount} to DownThemAll!"
    end
  end

  def twitter_share_link
    "https://twitter.com/intent/tweet?text=" +
      CGI::escape(share_text + " http://bit.ly/donate_dta")
  end

  def facebook_share_link
    "http://www.facebook.com/dialog/feed?" +
      "app_id=321813727854677&" +
      "display=popup&" +
      "redirect_uri=#{CGI::escape("http://downthemall.net")}&" +
      "link=#{CGI::escape("http://downthemall.net/donations/new")}&" +
      "name=#{CGI::escape("DownThemAll! Donations page")}&" +
      "description=#{CGI::escape("DownThemAll! is completely free to use but, if you find it useful, then please consider contributing some money back to the project")}&" +
      "caption=#{CGI::escape(share_text)}"
  end

  def self.amounts
    [
      DonationAmount.new(:coffee,  3, "a hot italian cappiccino"),
      DonationAmount.new(:beer,    5, "a cold dutch beer"),
      DonationAmount.new(:burger, 10, "a crispy bacon burger"),
      DonationAmount.new(:cinema, 15, "a ticket for the next Pixar movie"),
      DonationAmount.new(:book,   20, "some new novel book to read"),
      DonationAmount.new(:gift,   25, "a special gift")
    ]
  end

end
