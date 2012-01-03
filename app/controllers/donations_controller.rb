class DonationsController < ApplicationController
  inherit_resources
  actions :all, :except => [:index, :destroy]
  before_filter :set_donation_amounts

  def success
  end

  def cancel
  end

  def notify
  end

  private

  def set_donation_amounts
    @donation_amounts = [
      DonationAmount.new(:coffee,  3, "a hot italian cappiccino"),
      DonationAmount.new(:beer,    5, "a cold dutch beer"),
      DonationAmount.new(:burger, 10, "a crispy bacon burger"),
      DonationAmount.new(:cinema, 15, "a ticket for the next Pixar movie"),
      DonationAmount.new(:book,   20, "some new novel book to read"),
      DonationAmount.new(:gift,   20, "a special gift")
    ]
  end

end
