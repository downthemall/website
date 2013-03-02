class Donation < ActiveRecord::Base
  validates_presence_of :amount

  STATUS_PENDING = :pending
  STATUS_FAILED = :failed
  STATUS_DONE = :done
  STATUS_CANCELED = :canceled

  CURRENCY_EUR = 'EUR'
  CURRENCY_USD = 'USD'

  validates_inclusion_of :status, in: [ STATUS_DONE, STATUS_PENDING, STATUS_FAILED, STATUS_CANCELED ]
  validates_inclusion_of :currency, in: [ CURRENCY_EUR, CURRENCY_USD ]
  validates :amount, numericality: { greater_than_or_equal_to: 1 }

  serialize :fail_reason

  def status
    if (( s = read_attribute(:status) ))
      s.to_sym
    else
      nil
    end
  end

  def cancel!
    self.status = Donation::STATUS_CANCELED
    save!
  end

end
