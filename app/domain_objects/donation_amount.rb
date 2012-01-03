class DonationAmount
  attr_reader :icon, :amount, :description

  def initialize(icon, amount, description)
    @icon = icon
    @amount = amount
    @description = description
  end

end
