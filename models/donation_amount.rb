class DonationAmount < Struct.new(:icon, :amount, :description)

  def self.all
    [
      DonationAmount.new(:coffee,  3, "Italian cappuccino"),
      DonationAmount.new(:beer,    5, "Cold dutch beer"),
      DonationAmount.new(:burger, 10, "Crispy bacon burger"),
      DonationAmount.new(:cinema, 15, "Cinema ticket"),
      DonationAmount.new(:book,   20, "Novel book"),
      DonationAmount.new(:gift,   25, "Special gift")
    ]
  end

end

